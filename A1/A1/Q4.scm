#lang scheme

(define (create-symbol-table ll)
  ll)

(define (extend-symbol-table ll l2)
  (append l2 ll)
  )

(define (lookup ll e)
  (cond
    ((null? ll)
     '())
    ((equal? e (caar ll))
     (cadar ll))
    (else
     (lookup (cdr ll) e))))