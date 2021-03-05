#lang racket

(define (from-to f t) (if (= f t) '() (cons f (from-to (+ f 1) t))))

(define stack '())
(define (push val) (begin (set! stack (cons val stack)) (- (length stack) 1)))
(define (pop) (let ((tmp (car stack))) (begin (set! stack (cdr stack)) tmp)))
(define (stack-ref ptr) (list-ref (reverse stack) ptr))

(define heap (vector #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f #f)) ;; heap size 16
(define (halloc size)
  (define (find-empty pos)
    (if (vector-ref heap pos)
      (find-empty (+ pos 1))
      (if (andmap (lambda (x) (eq? x #f)) (take (list-tail (vector->list heap) pos) size))
        (begin (for-each (lambda (p) (vector-set! heap p #t)) (from-to pos (+ pos size))) pos)
        (find-empty (+ pos 1)))))
  (find-empty 0)) ;; return heap pointer
(define (heap-ref ptr) (vector-ref heap ptr))
(define (hfree ptr size)
  (for-each (lambda (p) (vector-set! heap p #f)) (from-to ptr (+ ptr size))))

(define (auto-var content size)
  (define ptr (last (map (lambda (x) (push (list-ref content x))) (from-to 0 size))))
  (define sz size)
  (define status #t)
  (lambda (msg) 
    (if (eq? status #t) 
      (cond ((eq? msg 'expire) 
               (begin 
                 (for-each (lambda (x) (pop)) (from-to 0 sz))
                 (set! status #f)))
             ((eq? msg 'content) (stack-ref ptr))
             ((eq? msg 'contents) (map (lambda (x) (stack-ref x)) (from-to ptr sz)))
             ((eq? msg 'tag) 'auto)
             ((eq? msg 'ptr) ptr)
             (else (error "unknown msg")))
      'expired!)))

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
            ((eq? msg 'contents) (map (lambda (x) (heap-ref x)) memory))
            ((eq? msg 'expire) (hfree pointer sz))
            ((eq? msg 'tag) 'dyn)
            ((eq? msg 'ptr) pointer)
            (else (error "unknown msg")))
    'expired!)))

(define (write-heap ptr size content) 
  (for-each 
    (lambda (p) 
      (if (eq? (vector-ref heap p) #f)
        (error "not allocated memory!")
        (vector-set! heap p (list-ref content p)))) (from-to ptr (+ ptr size))))

(define (read-heap ptr size) 
  (take (drop (vector->list heap) ptr) size))

;; simulate a scope (auto delete auto variables when out of scope)
;; v :: variable lsit
(define (scope v)
  (define vars v)
  (lambda (msg)
    (cond ((eq? msg 'expire)
            (for-each (lambda (x) (if (eq? 'auto (x 'tag)) (x 'expire) '())) vars))
          ((eq? msg 'vars) (map (lambda (x) (x 'content)) vars))
          (else (error "unknown msg")))))

;; moniter memory
(define (show-memory)
  (begin
    (display stack)
    (newline)
    (display heap)
    (newline)))

;; testing vars
(define a-ptr (halloc 2))
(define b-ptr (halloc 4))
(define x (auto-var '(1 2 3) 3))
(define y (auto-var '(65) 1))
(define a (dyn-var a-ptr 2 '(332 233)))
(define b (dyn-var b-ptr 4 '(hi hi bye bye)))
(define test-scope (scope (list a x y b)))

;; try using heap and stack
;; notice dyn var not cleaned up
(define (add p q)
  ;; intro vars, one auto, the other dynamic
  (define p1 (auto-var (list p) 1))
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

;; TODO: linked list example
