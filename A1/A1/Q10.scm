#lang scheme

(define (removelist ll)
  (cond
      ((null? ll)
       '())
      ((list? (car ll))
       (append (removelist (car ll)) (removelist (cdr ll))))
      (else
       (cons (car ll) (removelist (cdr ll))))))

(define (depth ll)
    (cond
      ((list? ll)
       (+ 1 (depth(car ll))))
      (else
       0)))

(define maximum-argument
    (letrec ((largest
        (lambda (ll e)
        (if (empty? ll)
        e
        (if (>= (depth e) (depth (car ll)))
             (largest (cdr ll) e)
             (largest (cdr ll) (car ll)))))))
    (lambda (ll)
    (if (empty? ll)
    '()
    (largest (cdr ll) (car ll))))))

(define (lowest-level d ll)
  (cond
    ((equal? d 0)
    ll)
    (else
     (list (lowest-level (- d 1) ll))))) 

(define (push-element ll)
  (define d (depth (maximum-argument ll)))
  (lowest-level d (removelist ll))
 )