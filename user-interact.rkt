#lang racket/base

(require "miniconda-commands.rkt")
(require "install-sequence.rkt")

(define (install-miniconda-and-jax-set)
  (install-miniconda #:install-from 'tuna)
  (create-jax-env "jax")
  (install-jax-optimize-set-in "jax")
  (install-plot-set-in "jax"))

(define if-mc-j install-miniconda-and-jax-set)
;; if-mc-j -> install full miniconda jax (set)