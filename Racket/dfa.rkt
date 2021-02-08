#lang racket

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

(define start-state cadddr)
(define trans-func caddr)

(define (do-automata automata inputs)
    (define (do-state state input)
        (if (eq? state 'fail) 'die
            (if (null? input) state
                (do-state ((trans-func automata) state (car input)) (cdr input)))))
    (do-state (start-state automata) inputs))
