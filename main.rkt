#lang racket/base

(require racket/port
         racket/runtime-path
         racket/random)

(provide generate-cute-id)

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
  ;; TODO: real tests
  (check-equal? (+ 2 2) 4))

(module+ main
  (require racket/cmdline)
  (define who (box "world"))
  (command-line
    #:program "generate-cute-id"
    #:args ()
    (printf (generate-cute-id))))
