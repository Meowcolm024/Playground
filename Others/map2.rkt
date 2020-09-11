(define (my-map f xs)
    (if (null? xs) 
        '() 
        (cons (f (car xs)) (my-map f (cdr xs)))))