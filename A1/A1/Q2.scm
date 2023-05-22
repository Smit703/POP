#lang scheme

(define (iteration-space list)
  (define (loop i max inc)
    (cond((<= i max)
      (cons i (loop (+ i inc) max inc)))
      (else
      '())))
  (apply loop list))

(define (for-loop f ll)
  (map f (iteration-space ll)))