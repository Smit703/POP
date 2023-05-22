#lang scheme

(define unmix
  (lambda (l1)
    (apply  map list l1)
   ))

(define mix
  (lambda (l1 l2)
    (apply map list (list l1 l2))
    )
 )