;;; init.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023
;;
;; Author:  mahmoud eltahawy
;; Maintainer:  mahmoud eltahawy
;; Created: June 20, 2023
;; Modified: June 20, 2023
;; Version: 0.0.1
;; Homepage: https://github.com/mahmoud-eltahawy/dotfiles
;; Package-Requires: ((emacs "29"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Code:
;;;

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(defun mt-path (name) (concat "~/magit/dotfiles/emacs/settings/" name))

;;comment this line after successfully installing the packages packages
;; (load (mt-path "packages.el"))

(setq use-package-always-ensure t)

(load (mt-path "dev.el"))
(-> "keys.el" mt-path load)
(-> "org.el" mt-path load)
(-> "look.el" mt-path load)
