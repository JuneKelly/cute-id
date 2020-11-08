#lang racket/base

(require racket/port
         racket/runtime-path
         racket/contract
         racket/string
         racket/list
         racket/random)

(provide (contract-out
          [cute-id
           (->* ()
                (#:separator string?)
                (and/c string? non-empty-string?))]
          [make-cute-id-fn
           (-> list? list? string? procedure?)]))

(define-runtime-path adjectives-data "data/adjectives.txt")
(define-runtime-path animal-data "data/animals.txt")

(define adjectives
  (call-with-input-file adjectives-data port->lines))

(define animals
  (call-with-input-file animal-data port->lines))

;; TODO:
;;   - documentation

(define (make-cute-id-fn
         adjective-list
         animal-list
         default-separator)
  (lambda (#:separator [separator default-separator])
    (let ([adj1 (random-ref adjective-list)]
          [adj2 (random-ref adjective-list)]
          [animal (random-ref animal-list)])
      (format "~a~a~a~a~a"
              adj1
              separator
              adj2
              separator
              animal))))

(define cute-id (make-cute-id-fn adjectives animals "-"))

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define generator-tests
    (test-suite
     "Tests for make-cute-id-fn"

     (let ([one-note (make-cute-id-fn '("a") '("b") "-")])
       (check-equal? (one-note) "a-a-b"))))

  (define cute-id-tests
    (test-suite
     "Tests for the cute-id function"
     (for ([s (for/list ([_i (range 1000)])
                (cute-id))])
       (check-pred string? s)
       (check-pred non-empty-string? s)
       (check-not-false (regexp-match #rx"^[a-zA-Z]+-[a-zA-Z]+-[a-zA-Z]+$" s)))

     (check-pred (lambda (s) (string-contains? s "-"))
                 (cute-id))

     (check-pred (lambda (s) (string-contains? s ":"))
                 (cute-id #:separator ":"))))

  (run-tests generator-tests)
  (run-tests cute-id-tests))

(module+ main
  (require racket/cmdline)
  (command-line
    #:program "cute-id"
    #:args ()
    (printf (cute-id))))
