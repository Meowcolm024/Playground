(define entry car)
(define left-branch cadr)
(define right-branch caddr)
(define make-tree list)

(define (element-of-set? x set)
    (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set)) 
            (element-of-set? x (left-branch set)))
        ((> x (entry set))
            (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
    (cond ((null? set) (make-tree x '() '() ))
        ((= x (entry set)) set)
        ((< x (entry set))
            (make-tree (entry set) (adjoin-set x (left-branch set)) (right-branch set)))
        ((> x (entry set))
            (make-tree (entry set) (left-branch set) (adjoin-set x (right-branch set))))))

(define a '(2 (1 () ()) (3 () ())) )

(define b '(3 (2 () ()) (4 () ())) )