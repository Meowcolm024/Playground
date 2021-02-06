#lang racket

(define (naive-person fname lname)                          ;; non-oo object
    (list 'person fname lname))

(define (person fn ln)                                      ;; constructor
    (let ((fname fn)                                        ;; members
          (lname ln))
         (define (dispatch message)                         ;; methods
            (cond
                ((eq? message 'first-name) fname)
                ((eq? message 'last-name) lname)
                ((eq? message 'set-fname)                   ;; method with args
                    (lambda (new-name) (set! fname new-name)))
                ((eq? message 'copy) (person fname lname))  ;; copy constructor
                ((eq? message 'show) 
                    (string-append fname " " lname))
                (else (error "Unknown message"))))
        dispatch))

(define (first-name p) (p 'first-name))
(define (last-name p) (p 'last-name))
(define (show p) (p 'show))
(define (copy p) (p 'copy))
(define (set-fname! p new-name) ((p 'set-fname) new-name))

(define (person+ bs ag)                                     ;; constructor using base class
    (let ((base bs)                                         ;; base class
          (age ag))                                         ;; new member
         (define (dispatch message)                         ;; methods
            (cond
                ((eq? message 'age) age)                    ;; new method
                ((eq? message 'grow) (set! age (+ age 1)))  ;; new method with side-effect
                ((eq? message 'copy) (person+ (base 'copy) age))
                ((eq? message 'show)                        ;; override base class 'show'
                    (string-append (bs message) " " (number->string age)))
                (else (base message))))                     ;; inherit base class methods
    dispatch))

(define (age p) (p 'age))
(define (grow! p) (p 'grow))

(define (person+1 fn ln ag)                                 ;; another constructor for person+
    (person+ (person fn ln) ag))

;; instances
(define alice (naive-person "kat" "alice"))                 ;; none-oop approach
(define jack (person "mat" "jack"))                         ;; base class
(define old-jack (person+ jack 60))                         ;; construct using base class (reference)
(define ben (person+1 "han" "ben" 10))                      
(define ben-2 (copy ben))                                   ;; copy of 'ben' object
