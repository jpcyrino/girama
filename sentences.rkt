#lang racket

;; Sentences implemented as a closure

(define (sentences list-of-sentences)
  (let ([sentence-list list-of-sentences]
        [separators (list " " "-")])
    (lambda (message)
      (case message
        [(get-sentences) sentence-list]
        [(get-separators) separators]
        [(add-separators) (lambda (list-of-separators)
                            (set! separators
                                  (append list-of-separators separators)))]
        [(add-separator) (lambda (separator)
                           (set! separators
                                 (cons separator separators)))]
        [else (error "didn't understand message")]))))
     
(define (language name sentences)
  (let ([name name]
        [sentences sentences])
    (lambda (message)
      (case message
        [(get-name) name]
        [(set-name) (lambda (new-name) (set! name new-name))]
        [(get-sentences) (sentences 'get-sentences)]))))
