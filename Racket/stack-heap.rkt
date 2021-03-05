#lang racket
;; helper function
(define (from-to f t) (if (= f t) '() (cons f (from-to (+ f 1) t))))

(define (make-stack)
  (define stack (vector #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)) ;; stack size 16
  (define pointer 0)
  (lambda (msg)
    (cond ((eq? msg 'push) 
            (lambda (x) 
              (begin (vector-set! stack pointer x) (set! pointer (+ pointer 1)) (- pointer 1))))
          ((eq? msg 'pop)
            (begin 
              (set! pointer (- pointer 1))
              (define top (vector-ref stack pointer))
              (vector-set! stack pointer #f)
              top))
          ((eq? msg 'ref) (lambda (p) (vector-ref stack p)))
          ((eq? msg 'write) (lambda (p v) (vector-set! stack p v)))
          ((eq? msg 'show) stack)
          (else (error "unknown msg")))))
;; push var to stack
(define (push val) ((stack 'push) val))
;; pop stack
(define (pop) (stack 'pop))
;; reference
(define (stack-ref ptr) ((stack 'ref) ptr))
;; write stack
(define (stack-write ptr size val) 
  (for-each (lambda (p) ((stack 'write) p (list-ref val p))) (from-to ptr (+ ptr size))))
;; new stack
(define stack (make-stack))

;; new heap
(define heap (vector #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)) ;; heap size 16
;; allocate memery in heap
(define (halloc size)
  (define (find-empty pos)  ;; find available memerory
    (if (vector-ref heap pos)
      (find-empty (+ pos 1))
      (if (andmap (lambda (x) (eq? x #f)) (take (list-tail (vector->list heap) pos) size))
        (begin (for-each (lambda (p) (vector-set! heap p #t)) (from-to pos (+ pos size))) pos)
        (find-empty (+ pos 1)))))
  (find-empty 0)) ;; return the pointer to heap
;; reference
(define (heap-ref ptr) (vector-ref heap ptr))
;; free memory
(define (hfree ptr size)
  (for-each (lambda (p) (vector-set! heap p #f)) (from-to ptr (+ ptr size))))

;; create auto variable (stack)
(define (auto-var size content)
  (define ptr (car (map (lambda (x) (push (list-ref content x))) (from-to 0 size))))
  (define sz size)
  (define status #t)
  (lambda (msg) 
    (if (eq? status #t) 
      (cond ((eq? msg 'expire) 
               (begin 
                 (for-each (lambda (x) (pop)) (from-to 0 sz))
                 (set! status #f)))
             ((eq? msg 'content) (stack-ref ptr))
             ((eq? msg 'contents) (map stack-ref (from-to ptr (+ ptr sz))))
             ((eq? msg 'tag) 'auto)
             ((eq? msg 'ptr) ptr)
             (else (error "unknown msg")))
      'expired!)))

;; create dynamic variable (heap)
(define (dyn-var ptr size content)
  (define pointer ptr)
  (define memory (begin 
                   (for-each 
                      (lambda (p) (vector-set! heap p (list-ref content (- p ptr))))
                      (from-to ptr (+ ptr size)))
                   (from-to ptr (+ ptr size))))
  (define sz size)
  (define status #t)
  (lambda (msg) 
    (if (eq? status #t)
      (cond ((eq? msg 'content) (heap-ref ptr))
            ((eq? msg 'contents) (map heap-ref memory))
            ((eq? msg 'expire) (hfree pointer sz))
            ((eq? msg 'tag) 'dyn)
            ((eq? msg 'ptr) pointer)
            (else (error "unknown msg")))
    'expired!)))

;; write heap via pointer
(define (heap-write ptr size content) 
  (for-each 
    (lambda (p) 
      (if (eq? (vector-ref heap p) #f)
        (error "not allocated memory!")
        (vector-set! heap p (list-ref content p)))) (from-to ptr (+ ptr size))))
;; read heap via pointer
(define (heap-read size ptr) 
  (take (drop (vector->list heap) ptr) size))

;; simulate a scope (delete auto variables when out of scope)
(define (scope var-list)
  (define vars var-list)
  (lambda (msg)
    (cond ((eq? msg 'expire)
            (for-each (lambda (x) (if (eq? 'auto (x 'tag)) (x 'expire) '())) vars))
          ((eq? msg 'vars) (map (lambda (x) (x 'content)) vars))
          ((eq? msg 'add) (lambda (n) (set! vars (append vars n))))
          (else (error "unknown msg")))))
;; append scope
(define (scope-add s n) ((s 'add) n))

;; moniter memory
(define (show-memory)
  (begin
    (display "memory\n  ")
    (display (stack 'show))
    (display "\n  ")
    (display heap)
    (newline)))


;; EXAMPLES BELOW OwO


;; try using heap and stack
;; notice dyn var not cleaned up
(define (add p q)
  ;; intro vars, one auto, the other dynamic
  (define p1 (auto-var 1 (list p)))
  (define q1 (dyn-var (halloc 1) 1 (list q)))
  ;; add variables to current scope
  (define spq (scope (list p1 q1)))
  (begin
    (define result (+ (p1 'content) (q1 'content)))
    ;; cleanup when out of scope
    (spq 'expire)
    ;; return value p1 is null, p2 has something
    (list result p1 q1)))

;; example with halloc and hfree
(define (box val)
  (define v (dyn-var (halloc 1) 1 (list val)))
  (define status #t)
  (lambda (msg)
    (if (eq? status #t)
      (cond ((eq? msg 'val) (v 'content))
            ((eq? msg 'destruct) (begin (v 'expire) (set! status #f)))
            (else (error "unknown msg")))
      'destructed)))

;; demo
(define (example)
  (begin
    ;; before loading vars
    (displayln ":: program started")
    (show-memory)
    ;; allocate ptr for var 1 and 2
    (define ptr1 (halloc 3))
    (define ptr2 (halloc 4))
    (define var1 (dyn-var ptr1 3 '(a b c)))
    (define var2 (dyn-var ptr2 4 '(1 2 3 4)))
    ;; auto managed var 3 and 4
    (define var3 (auto-var 1 '("bbb")))
    (define var4 (auto-var 3 '(6 6 6)))
    ;; into scope
    (define eg-scope (scope (list var1 var2 var3 var4)))
    (show-memory)
    ;; stack buffer overflow (write)
    (stack-write (var3 'ptr) 2 '(X D))
    (display "var3 ")
    (displayln (var3 'contents))
    (display "var4 ")
    (displayln (var4 'contents))
    (show-memory)
    ;; heap buffer overflow (write)
    (heap-write ptr1 5 '(o v e r !))
    ;; show result
    (display "var1 ")
    (displayln (var1 'contents))
    (display "var2 ")
    (displayln (var2 'contents))
    ;; heap buffer overflow (read)
    (displayln (heap-read 7 ptr1))
    ;; free ptr1
    (hfree ptr1 3)
    (show-memory)
    ;; allocate new var 5 and 6 without explict pointers
    (define var5 (dyn-var (halloc 6) 6 '(r a c k e t)))
    (define var6 (dyn-var (halloc 1) 1 '(233)))
    ;; add to scope
    (scope-add eg-scope (list var5 var6))
    ;; notice where var 6 goes
    (show-memory)
    ;; when exit
    ;; free var 5 (obtion pointer from variable)
    (hfree (var5 'ptr) 6)
    ;; this does not clean var 4 and var 6
    (eg-scope 'expire)
    (show-memory)
    (displayln ":: program ended")
  )
)

;; main
(example)
