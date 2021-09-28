#lang racket
(require "sentence.rkt")
(provide ocun-text)

;; Contract: ocun-text string -> list

;; Purpose: imports data from an ocun text file into the girama ecosystem

;; Example: (ocun-text "daaichin.txt") will yield a list of the sentence struct based on
;;          the data from the daaichin.txt file.

;; Definition:
(define (ocun-text txt-file)
  (let ([sentence-vector (text-file-line-to-vector txt-file)])
    (vector-multiple-of-3? sentence-vector)
    (vector-to-sentence-struct sentence-vector)))

;; Gets lines from a text file and transforms to vector
(define (text-file-line-to-vector f)
  (with-handlers ([exn:fail? (lambda (e) 'file_error)])
    (with-input-from-file f
      (lambda ()
        (for/vector ([line (in-lines)])
          line)))))


;; Transforms a vector of sentences into a list of sentence structs
(define (vector-to-sentence-struct v)
  (let loop ([acc 0]
             [n (vector-length v)]
             [l '()])
    (if (< n 1)
        (reverse l)
        (loop (+ acc 3) (- n 3)
              (cons
               (sentence
                (vector-ref v acc) (vector-ref v (+ acc 1)) (vector-ref v (+ acc 2))) l)))))

;; Auxiliary functions
(define (vector-multiple-of-3? l)
  (when (not (multiple-of-3? (vector-length l)))
    (error "Incomplete data")))

(define (multiple-of-3? n)
  (= (remainder n 3) 0))

;; Tests:
(module+ test
  (require rackunit)
  (check-equal? (vector-to-sentence-struct '#(1 2 3 4 5 6))
                (list (sentence 1 2 3) (sentence 4 5 6))))

