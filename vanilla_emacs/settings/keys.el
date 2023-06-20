;;; keys.el --- Description -*- lexical-binding: t; -*-

(use-package evil
  :config
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))
