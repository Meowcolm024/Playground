(define (apply-generic op . args)
    (let ((typr-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (error "No matched type")))))

(define (type-tag datum)
    (if (pair? datum) (car datum) (error "Bad! " datum)))

(define (contents datum)
    (if (pair? datum) (cdr datum) (error "Bad! " datum)))

(define (atatch-tag type-tag contents)
    (cons type-tag contents))

(define (add x y)
    (apply-generic 'add x y))

(define (install-scheme-number-package)
    (define (tag x) (atatch-tag 'scheme-number x))
    (put 'add '(scheme-number scheme-number) (lambda (x y) (+ x y)))
    'done )

;; no `put` built-in :(

