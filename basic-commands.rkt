#lang racket/base

(require racket/system)

(require "utils.rkt")

(provide mkdir-p
         bash
         rm-rf
         apt-get-update
         apt-get-install
         wget)

(define (path-ensure-string pth)
  (if (path? pth)
      (path->string pth)
      pth))

(define (bash . lst)
  (system (build-command (cons "bash" lst))))

(define (mkdir-p dir)
  (system (build-command `("mkdir" "-p" ,(path-ensure-string dir)))))

(define (rm-rf pth)
  (system (build-command `("rm" "-rf" ,(path-ensure-string pth)))))

(define (apt-get-update)
  (system (build-command `("apt-get" "update"))))

(define (apt-get-install pkgs)
  (system (build-command `("apt-get" "install" "-y" ,@pkgs))))

(define (wget url save-dir [save-name #f])
  (if save-name
      (let ([save-path (build-path save-dir save-name)])
        (system (build-command `("wget" ,url "-O" ,(path->string save-path)))))
      (system (build-command `("wget" ,url "-P" ,(path-ensure-string save-dir))))))