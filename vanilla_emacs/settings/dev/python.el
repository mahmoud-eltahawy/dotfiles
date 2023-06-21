;;; python.el --- Description -*- lexical-binding: t; -*-

(use-package python-mode
  :custom
  :hook (python-mode . lsp-deferred)
  (python-shell-interpreter "python3"))

(use-package pyvenv
  :config
  (pyvenv-mode 1))
