#lang racket/base

(require racket/port
         racket/runtime-path
         racket/contract
         racket/string
         racket/list
         racket/random)

(provide (contract-out
          [generate-cute-id
           (->* ()
                (#:separator string?)
                (and/c string? non-empty-string?))]))

(define-runtime-path adjectives-data "data/adjectives.txt")
(define-runtime-path animal-data "data/animals.txt")

(define adjectives
  (call-with-input-file adjectives-data port->lines))

(define animals
  (call-with-input-file animal-data port->lines))

(define (random-adjective)
  (random-ref adjectives))

(define (random-animal)
  (random-ref animals))

;; TODO: documentation
(define (generate-cute-id #:separator [separator "-"])
  (let ([adj1 (random-adjective)]
        [adj2 (random-adjective)]
        [animal (random-animal)])
    (format "~a~a~a~a~a"
            adj1
            separator
            adj2
            separator
            animal)))

(module+ test
  (require rackunit)

  (for ([s (for/list ([_i (range 1000)])
             (generate-cute-id))])
    (check-pred string? s)
    (check-pred non-empty-string? s))

  (check-pred (lambda (s) (string-contains? s "-"))
              (generate-cute-id))

  (check-pred (lambda (s) (string-contains? s ":"))
              (generate-cute-id #:separator ":")))

(module+ main
  (require racket/cmdline)
  (command-line
    #:program "generate-cute-id"
    #:args ()
    (printf (generate-cute-id))))
