#lang racket/base

(require racket/string)

(provide build-command
         qotof)

(define (build-command lst)
  (string-join lst " "))

(define (qotof s)
  (string-append "\"" s "\""))
