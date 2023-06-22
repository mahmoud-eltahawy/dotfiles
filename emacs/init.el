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

(defun mt-path (name) (concat "~/magit/workflow/emacs/settings/" name))

;;comment this line after successfully installing the packages packages
(load (mt-path "packages.el"))

(require 'use-package)
(setq use-package-always-ensure t)

(load (mt-path "look.el"))
(load (mt-path "dev.el"))
(load (mt-path "keys.el"))
(load (mt-path "org.el"))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rustic treemacs-icons-dired use-package tree-sitter-langs rust-mode org-auto-tangle nerd-icons-ivy-rich nerd-icons-dired magit lsp-ui ligature evil-surround doom-themes doom-modeline dap-mode counsel company all-the-icons))
 '(warning-suppress-log-types '((comp) (comp) (comp)))
 '(warning-suppress-types '((comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
