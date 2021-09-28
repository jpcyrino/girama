#lang racket

(provide (struct-out sentence) sentences%)
(module+ test
  (require rackunit))

(struct sentence (language gloss translation))

(define sentences%
  (class object%
    
    (init sentence-list)
    
    (super-new)
    
    (define sentences sentence-list)
    (define separators (list " " "-"))
    
    (define/public (get-sentences) sentences)
    (define/public (get-separators) separators)
    (define/public (add-separator separator)
      (set! separators (cons separator separators)))
    (define/public (add-separators separator-list)
      (set! separators (append separator-list separators)))
    
    (define/public (get-morphs mode) 'implement)))


;; Tests
(module+ test
      (define sentences-mock (list
                              (sentence "une première phrase"
                                        "uma primeira frase"
                                        "a first sentence")
                              (sentence "la deuxième phrase"
                                        "a segunda frase"
                                        "the second sentence")))
      
      (define sentences-obj (new sentences% [sentence-list sentences-mock]))
      (check-equal? (send sentences-obj get-sentences) sentences-mock)

      (send sentences-obj add-separator "#")
      (check-equal? (send sentences-obj get-separators) (list "#" " " "-"))

      (send sentences-obj add-separators (list "$" "@"))
      (check-equal? (send sentences-obj get-separators) (list "$" "@" "#" " " "-")))
