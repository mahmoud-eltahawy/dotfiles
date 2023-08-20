;;; dev.el --- Description -*- lexical-binding: t; -*-

(use-package dap-mode) ;; -> comes from this package

(electric-pair-mode 1)
(setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)

(-> "dev/auto-complete.el" mt-path load)

(-> "dev/rust.el" mt-path load)
(-> "dev/haskell.el" mt-path load)
(-> "dev/sql.el" mt-path load)
(-> "dev/eglot.el" mt-path load)

(use-package nix-mode
  :mode "\\.nix\\'")
(use-package yaml-mode)


