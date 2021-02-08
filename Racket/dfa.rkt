#lang racket

(define start-state cadddr)
(define trans-func caddr)
(define (final-state? automata state) 
    (if (member state (car (cddddr automata))) #t #f))

(define (do-automata automata inputs)
    (define (do-state state input)
        (if (eq? state 'fail) 'die
            (if (null? input) state
                (do-state ((trans-func automata) state (car input)) (cdr input)))))
    (do-state (start-state automata) inputs))

;; do the automation with inputs and output the result state
(define (automation automata inputs)
    (let ((output (do-automata automata inputs)))
    (if (final-state? automata output)
        (displayln (string-append "final state " (symbol->string output) " reached"))
        (displayln (string-append "stopped at state " (symbol->string output))))))

;;
;; example automations
;;

;; accept 0  -> 1  -> any in {0, 1}
;; state  q0 -> q2 -> q1
(define dfa-01 
    (list '(q0 q1 q2)       ;; state set
          '(0 1)            ;; input set
          (lambda (st inp)  ;; trans func
            (cond ((eq? st 'q0) 
                   (cond ((eq? inp 0) 'q2)
                         ((eq? inp 1) 'q0)
                         (else 'fail))) 
                  ((eq? st 'q2) 
                   (cond ((eq? inp 1) 'q1)
                         ((eq? inp 0) 'q2)
                         (else 'fail)))
                  ((eq? st 'q1) 'q1)
                  (else 'fail)))
          'q0               ;; start state
          '(q1)             ;; final state
    ))

;; both even 0s and even 1s
(define dfa-even-01
    (let ((input-set '(0 1)))
    (list '(q0 q1 q2 q3)
          input-set
          (lambda (st inp)
            (if (member inp input-set)
                (cond ((eq? st 'q0) 
                       (cond ((eq? inp 0) 'q2)
                             ((eq? inp 1) 'q1)
                             (else 'q0))) 
                      ((eq? st 'q1) 
                       (cond ((eq? inp 0) 'q3)
                             ((eq? inp 1) 'q0)
                             (else 'q1)))
                      ((eq? st 'q3) 
                       (cond ((eq? inp 0) 'q1)
                             ((eq? inp 1) 'q2)
                             (else 'q3)))
                      ((eq? st 'q2) 
                       (cond ((eq? inp 0) 'q0)
                             ((eq? inp 1) 'q3)
                             (else 'q2))) 
                      (else 'fail))
                'fail))
          'q0
          '(q0)
    )))
