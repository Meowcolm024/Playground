; #lang sicp

(define front-ptr car)
(define rear-ptr cdr)

(define (set-front-ptr! queue item)
    (set-car! queue item))

(define (set-rear-ptr! queue item)
    (set-cdr! queue item))

(define (empty-queue? queue)
    (null? (front-ptr queue)))

(define (make-queue)
    (cons '() '() ))

(define (front-queue queue)
    (if (empty-queue? queue)
        (error "EMPTY")
        (car (front-ptr queue))))

(define (insert-queue! queue item)
    (let ((new-pair (cons item '() )))
        (cond ((empty-queue? queue) 
               (set-front-ptr! queue new-pair)
               (set-rear-ptr! queue new-pair)
               queue)
            (else 
               (set-cdr! (rear-ptr queue) new-pair)
               (set-rear-ptr! queue new-pair)
               queue))))

(define (delete-queue! queue)
    (cond ((empty-queue?) (error "EMPTY"))
        (else (set-front-ptr! queue (cdr front-ptr queue)) queue)))

#| (define (set-cdr! p x)
    (let ((q (cdr p)))
         (set! q x)))

(define (set-car! p x)
    (let ((q (car p)))
         (set! q x))) |#
