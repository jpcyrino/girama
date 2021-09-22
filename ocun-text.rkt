#lang racket

(define (text-file-line-to-list f)
  (with-handlers ([exn:fail? (lambda (e) 'nao_pode_abrir_arquivo)])
    (with-input-from-file f
      (lambda ()
        (for/list ([line (in-lines)])
          line)))))

(define (multiple-of-3 n)
  (= (remainder n 3) 0))
