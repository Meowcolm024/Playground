#lang racket

(require racket/list)

(define start-state cadddr)
(define trans-func caddr)

(define (do-automata automata inputs)
    (define (do-state state input)
        (if (null? input) state
            (append-map
                (lambda (s) (do-state s (cdr input)))
                (map (lambda (s) ((trans-func automata) s (car input))) state))))
    (do-state (list (start-state automata)) inputs))

;;
;; example automations
;;

;; string end with 0 1
(define nfa-end-01
    (list '(q1 q2 q3)
          '(0 1)
          (lambda (st inp)
            (if (member inp '(0 1))
                (cond ((eq? st 'q0)
                       (if (= inp 0) '(q0 q1) '(q0)))
                      ((eq? st 'q1)
                       (if (= inp 0) '() '(q2)))
                      ((eq? st 'q2)
                       (if (= inp 0) '() '())))
                'fail))
          'q0
          '(q2)
    ))
