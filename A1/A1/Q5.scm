#lang scheme

(define maximum-argument
    (letrec ((largest
        (lambda (f ll e)
        (if (empty? ll)
        e
        (if (>= (f e) (f (car ll)))
             (largest f (cdr ll) e)
             (largest f (cdr ll) (car ll)))))))
    (lambda (f ll)
    (if (empty? ll)
    '()
    (largest f (cdr ll) (car ll))))))