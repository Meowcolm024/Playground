(define (add-complex z1 z2)
    (make-from-real-imag 
        (+ (real-part z1) (real-part z2))
        (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
    (make-from-real-imag 
        (- (real-part z1) (real-part z2))
        (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
    (make-from-mag-ang
        (* (magnitude z1) (magnitude z2))
        (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
    (make-from-mag-ang
        (/ (magnitude z1) (magnitude z2))
        (- (angle z1) (angle z2))))

(define real-part-rectangular car)
(define imag-part-rectangular cdr)

(define (magnitude-rectangular z)
    (sqrt (+ (square (real-part-rectangular z)) (square (imag-part-rectangular z)))))

(define (angle-rectangular z)
    (atan (imag-part-rectangular z) (real-part-rectangular z)))

(define (make-from-real-imag-rectangular x y)
    (atatch-tag 'rectangular (cons x y)))

(define (make-from-mag-ang-rectangular r a)
    (atatch-tag 'rectangular (cons (* r (cos a)) (* r (sin a)))))

(define (square x) (* x x))

(define (real-part-polar z)
    (* (magnitude-polar z) (cos (angle-polar z))))

(define (imag-part-polar z)
    (* (magnitude-polar z) (sin (angle-polar z))))

(define magnitude-polar car)
(define angle-polar cdr)

(define (make-from-real-imag-polar x y)
    (atatch-tag 'polar (cons (sqrt (+ (square x) (square y)) (atan y x)))))

(define (make-from-mag-ang-polar r a)
    (attach-tag 'polar (cons r a)))

(define (atatch-tag type-tag contents)
    (cons type-tag contents))

(define (type-tag datum)
    (if (pair? datum) (car datum) (error "Bad! " datum)))

(define (contents datum)
    (if (pair? datum) (cdr datum) (error "Bad! " datum)))

(define (rectangular? z)
    (eq? (type-tag z) 'rectangular ))

(define (polar? z)
    (eq? (type-tag z) 'polar ))

(define (real-part z)
    (cond ((rectangular? z) (real-part-rectangular (contents z)))
        ((polar? z) (real-part-polar (contents z)))
        (else (error "Unknown"))))

(define (imag-part z)
    (cond ((rectangular? z) (imag-part-rectangular (contents z)))
        ((polar? z) (imag-part-polar (contents z)))
        (else (error "Unknown")))) 

(define (magnitude z)
    (cond ((rectangular? z) (magnitude-rectangular (contents z)))
        ((polar? z) (magnitude-polar (contents z)))
        (else (error "Unknown"))))

(define (make-from-real-imag x y)
    (make-from-real-imag-rectangular x y))

(define (make-from-mag-ang r a)
    (make-from-mag-ang-polar r a))
