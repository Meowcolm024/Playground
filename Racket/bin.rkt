#lang racket

(define (add x y c)
    (cond ((= (+ x y c) 3) (cons 1 1))
          ((= (+ x y c) 2) (cons 0 1))
          (else (cons (+ x y c) 0))))

(define (add-bin p q)
    (define (helper x y carry)
        (cond ((and (null? x) (null? y)) 
                (if (= carry 0) '() '(1)))
              ((and (null? x) (not (null? y)))
                (let ((result (add 0 (car y) carry))) 
                    (cons (car result) (helper '() (cdr y) (cdr result)))))
              ((and (not (null? x)) (null? y))
                (let ((result (add (car x) 0 carry))) 
                    (cons (car result) (helper (cdr x) '() (cdr result)))))
              (else
                (let ((result (add (car x) (car y) carry)))
                    (cons (car result) (helper (cdr x) (cdr y) (cdr result)))))))
    (reverse (helper (reverse p) (reverse q) 0)))
