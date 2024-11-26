#lang racket/base

(require "miniconda-commands.rkt")
(require "utils.rkt")

(provide create-jax-env
         install-jax-optimize-set-in
         install-plot-set-in)

(define (create-jax-env env-name #:gpu [gpu #t])
  (conda-create-env "jax" "python=3.11")
  (pip-install-in "jax"
                  (if gpu
                      (qotof "jax[cuda12]")
                      "jax")))

(define (install-jax-optimize-set-in env-name)
  (pip-install-in env-name "jaxopt" "optax"))

(define (install-plot-set-in env-name)
  (pip-install-in env-name "matplotlib" "seaborn"))
