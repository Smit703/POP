#lang scheme

(define (iter-fib n)
  (define (fib count curr prev)
    (if(= count 2)
       curr
       (fib(- count 1) (+ curr prev) curr)))
  (cond
    ((= n 0)
    0)
    ((= n 1)
     1)
    (else
     (fib n 1 1)))
  )