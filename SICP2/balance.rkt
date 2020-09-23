(define balance 100)

(define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
            balance)
        "Insufficiant funds"))

(define new-withdraw
    (let ((balance2 100))
        (lambda (amount)
            (if (>= balance2 amount)
                (begin (set! balance2 (- balance2 amount))
                    balance2)
                "Insufficiant funds"))))

(define (make-withdraw balance3)
    (lambda (amount)
        (if (>= balance3 amount)
                (begin (set! balance3 (- balance2 amount))
                    balance3)
                "Insufficiant funds")))

(define (make-account balance)
    (define (withdraw amount)
        (if (>= balance amount)
        (begin (set! balance (- balance amount))
            balance)
        "Insufficiant funds"))
    (define (deposit amount)
        (set! balance (+ balance amount)))
    (define (dispatch m)
        (cond ((eq? m 'withdraw ) withdraw)
            (eq? m 'deposit ) deposit
            (else (error "Unknown request"))))
    dispatch)
    