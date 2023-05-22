#lang scheme

(define (delete ll e)
    (cond
      ((null? ll)
       '())
      ((equal? (car ll) e)
       (cdr ll))
      (else
       (cons (car ll) (delete (cdr ll) e)))))

(define (list-minus l1 l2)
  (cond
    ((null? l2)
     l1)
    (else
     (list-minus (delete l1 (car l2)) (cdr l2))
     )))

(define (similar ff v ll l2)
    (cond
      ((null? ll)
      l2)
      ((ff v (car ll))
      (cons (car ll) (similar ff v (cdr ll) l2)))
      (else
       (similar ff v (cdr ll) l2))))

(define (eqGroupify ff ll)
   (cond
    ((null? ll)
     '())
    (else
     (append (list (similar ff (car ll) ll '())) (eqGroupify ff (list-minus ll (similar ff (car ll) ll '()))))
     )))