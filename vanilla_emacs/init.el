;;; init.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023
;;
;; Author:  mahmoud eltahawy
;; Maintainer:  mahmoud eltahawy
;; Created: June 20, 2023
;; Modified: June 20, 2023
;; Version: 0.0.1
;; Homepage: https://github.com/mahmoud-eltahawy/workflow
;; Package-Requires: ((emacs "28.2"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Code:
;;;

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(defun path (name) (concat "/root/.emacs.d/settings/" name))

;;comment this line after successfully installing the packages packages
(load (path "packages.el"))

(require 'use-package)

(load (path "look.el"))
(load (path "dev.el"))
(load (path "keys.el"))
(load (path "org.el"))
