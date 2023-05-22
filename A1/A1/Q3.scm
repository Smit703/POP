#lang scheme

(define i -1)

(define (curr ll e)
  (cond
    ((equal? e 0)
     (car ll))
    (else
     (curr (cdr ll) (- e 1)))))

(define (size ll s)
  (cond
    ((empty? ll)
     s)
    (else
     (size (cdr ll) (+ s 1)))))

(define (make-iterator list)
  (define (loop i max inc)
    (cond((<= i max)
      (cons i (loop (+ i inc) max inc)))
      (else
      '())))
  (apply loop list))

(define (next ll)
  (define s (size ll 0))
  (set! i (+ i 1))
  (cond
    ((>= i s)
    '())
    (else
     (curr ll i)
     ))
  )

(define (hasNext ll)
  (cond
    ((< (+ i 1) (size ll 0))
     #t)
    (else
     #f)))