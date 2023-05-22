#lang scheme

(define (make-setty-list ll)
  (cond
    ((null? ll)
     '())
    ((null? (cdr ll))
     ll)
    ((equal? (car ll) (cadr ll))
     (make-setty-list (cdr ll)))
    (else
     (cons (car ll) (make-setty-list (cdr ll))))))

(define (setty-list-union l1 l2)
  (make-setty-list (append l1 l2)))

(define (delete ll e)
    (cond
      ((null? ll)
       '())
      ((equal? (car ll) e)
       (cdr ll))
      (else
       (cons (car ll) (delete (cdr ll) e) ))))

(define (setty-list-minus l1 l2)
  (cond
    ((null? l2)
     (make-setty-list l1))
    (else
     (setty-list-minus (delete l1 (car l2)) (cdr l2)))
     ))