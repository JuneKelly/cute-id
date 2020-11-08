#lang racket/base

(require racket/port
         racket/runtime-path
         racket/contract
         racket/string
         racket/list
         racket/random)

(provide (contract-out
          [generate-cute-id (-> (and/c string? non-empty-string?))]))

(define-runtime-path animal-data "data/animals.txt")
(define-runtime-path adjectives-data "data/adjectives.txt")

(define animals
  (call-with-input-file animal-data port->lines))

(define adjectives
  (call-with-input-file adjectives-data port->lines))

;; TODO: documentation
(define (generate-cute-id)
  (let ([adj1 (random-ref adjectives)]
         [adj2 (random-ref adjectives)]
         [animal (random-ref animals)]
         [sep "-"])
    (format "~a~a~a~a~a"
            adj1
            sep
            adj2
            sep
            animal)))

(module+ test
  (require rackunit)

  (define test-ids
    (for/list ([i (range 1000)])
      (generate-cute-id)))

  (for ([s test-ids])
    (check-pred string? s)
    (check-pred non-empty-string? s)))

(module+ main
  (require racket/cmdline)
  (define who (box "world"))
  (command-line
    #:program "generate-cute-id"
    #:args ()
    (printf (generate-cute-id))))
