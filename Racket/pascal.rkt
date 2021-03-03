#lang racket

;; n: items need to be computed
;; xs: current row
;; l: (current) row length
(define (pascal-iter n xs l)
    (if (>= l n)        ;; abort when current row length > needed
        (list n xs)     ;; return index and current row
        (pascal-iter    ;; generate next row using current row
            (- n l) (map + (append xs '(0)) (cons 0 xs)) (+ l 1))))

(define (pascal n)
    (let ((result (pascal-iter n '(1) 1)))
        (list-ref (cadr result) (- (car result) 1))))

