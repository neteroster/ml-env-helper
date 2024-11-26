#lang racket/base

(require racket/system)

(require "basic-commands.rkt")
(require "utils.rkt")

(provide conda
         conda-run-in
         conda-create-env
         conda-install-in
         pip-install-in
         env-exist?
         install-miniconda)

(define miniconda-default-installer-url
  "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh")

(define miniconda-tuna-mirror-install-url
  "https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh")

(define (conda . cmds)
  (system (build-command (cons "conda" cmds))))

(define (conda-run-in env-name cmd)
  (apply conda `("run" "--live-stream" "-n" ,env-name ,cmd)))

(define (conda-create-env env-name . pkgs)
  (apply conda `("create" "-y" "-n" ,env-name ,@pkgs)))

(define (conda-install-in env-name . pkgs)
  (apply conda `("install" "-y" "-n" ,env-name ,@pkgs)))

(define (pip-install-in env-name . pkgs)
  (conda-run-in env-name
                (build-command `("python" "-m" "pip" "install" ,@pkgs))))

(define (env-exist? env-name)
  (conda "list" "--name" env-name))

(define (install-miniconda
         #:install-from [install-from 'default])
  ;; steps from <https://docs.anaconda.com/miniconda/install/#quick-command-line-install>
  (mkdir-p "~/miniconda3")
  (let ([installer-url (cond ['tuna miniconda-tuna-mirror-install-url]
                             [else miniconda-default-installer-url])])
    (wget installer-url "~/miniconda3/" "miniconda.sh"))
  (bash "~/miniconda3/miniconda.sh" "-b" "-u" "-p" "~/miniconda3")
  (rm-rf "~/miniconda3/miniconda.sh")
  (conda "init" "--all"))