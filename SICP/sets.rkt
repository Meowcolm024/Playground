(define (element-of-set? x s)
    (cond ((null? s) false)
        ((equal? x (car s)) true)
        (else (element-of-set? x (cdr s)))))

(define (adjoin-set x s)
    (if (element-of-set? x s)
        s
        (cons x s)))

(define (intersection-set s1 s2)
    (cond ((or (null? s1) (null? s2)) '() )
        ((element-of-set? (car s1) s2)
            (cons (car s1) (intersection-set (cdr s1) s2)))
        (else (intersection-set (cdr s1) s2))))
