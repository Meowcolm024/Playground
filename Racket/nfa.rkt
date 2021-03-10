#lang racket

(require racket/list)

(define start-state cadddr)
(define trans-func caddr)
(define accepting-state last)

(define (do-automata automata inputs)
  (define (do-state state input)
      (if (null? input)
        state
        (append-map
          (lambda (s) (do-state s (cdr input)))
          (map (lambda (s) ((trans-func automata) s (car input))) state))))
  (do-state (list (start-state automata)) inputs))

;;
;; example automations
;;

;; string end with 0 1
(define nfa-end-01
  (list '(q0 q1 q2)
    '(0 1)
    (lambda (st inp)
      (if (member inp '(0 1))
          (cond ((eq? st 'q0)
                 (if (= inp 0) '(q0 q1) '(q0)))
                ((eq? st 'q1)
                 (if (= inp 0) '() '(q2)))
                ((eq? st 'q2) '()))
          'fail))
    'q0
    '(q2)
  ))

;; accept '(w e b) and '(e b a y)
(define nfa-str
  (let ((input-set '(a b c d e f g h i j k l m n o p q r s t u v w x y z)))
      (list '(q1 q2 q3 q4 q5 q6 q7 q8)
        input-set
        (lambda (st inp)
          (if (member inp input-set)
              (cond ((eq? st 'q1)
                      (cond ((eq? inp 'w) '(q1 q2))
                            ((eq? inp 'e) '(q1 q5))
                            (else '(q1))))
                    ((eq? st 'q2)
                      (if (eq? inp 'e) '(q3) '()))
                    ((eq? st 'q3)
                      (if (eq? inp 'b) '(q4) '()))
                    ((eq? st 'q5)
                      (if (eq? inp 'b) '(q6) '()))
                    ((eq? st 'q6)
                      (if (eq? inp 'a) '(q7) '()))
                    ((eq? st 'q7)
                      (if (eq? inp 'y) '(q8) '()))
                    ;; accepting states
                    ((eq? st 'q4) '(q4))
                    ((eq? st 'q8) '(q8)))
              'fail))
        'q1
        '(q4 q8)
      )))

;; math expr < > for ( )
;; -3 * (6 + 3) / (13 - 4) + 56
;; '(- 3 * < 6 + 3 > / < 1 3 - 4 > + 5 6)
(define nfa-math
  (let ((input-set '(0 1 2 3 4 5 6 7 8 9 + - * / < >)))
    (list '(q0 q1 q2 q3 q4 q5)
      input-set
      (lambda (st inp)
        (if (member inp input-set)
            (cond ((eq? st 'q0)   ;; start
                   (cond 
                    ((number? inp) '(q4))
                    ((eq? inp '-) '(q4))
                    ((eq? inp '<) '(q2))
                    (else '())))
                  ((eq? st 'q1)  ;; out of bracket after op
                   (cond 
                    ((number? inp) '(q4)) 
                    ((eq? inp '<) '(q2))
                    (else '())))
                  ((eq? st 'q2) ;; inside bracket before op
                   (cond 
                    ((number? inp) '(q2)) 
                    ((member inp '(+ - * /)) '(q3))
                    ((eq? inp '>) '(q5))
                    (else '())))
                  ((eq? st 'q3) ;; inside bracket after op
                   (cond 
                    ((number? inp) '(q2)) 
                    ((eq? inp '>) '(q5))
                    (else '())))
                  ((eq? st 'q4) ;; out of bracket before op
                   (cond 
                    ((number? inp) '(q4)) 
                    ((member inp '(+ - * /)) '(q1))
                    (else '())))
                  ((eq? st 'q5) ;; right after bracket
                   (cond  
                    ((member inp '(+ - * /)) '(q1))
                    (else '()))))
            'fail))
      'q0
      '(q0 q4 q5)
  )))
