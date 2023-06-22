;;; python.el --- Description -*- lexical-binding: t; -*-

(use-package python-mode
  :custom
    (python-shell-interpreter "python3")
  :hook (python-mode . lsp-deferred))

(use-package pyvenv
  :config
  (pyvenv-mode 1))
