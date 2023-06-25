;;; dev.el --- Description -*- lexical-binding: t; -*-

(electric-pair-mode 1)
(setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)

(load (mt-path "dev/auto-complete.el"))

(load (mt-path "dev/rust.el"))
(load (mt-path "dev/haskell.el"))
(load (mt-path "dev/sql.el"))


(use-package nix-mode
  :mode "\\.nix\\'")
(use-package yaml-mode)

;;; Debug
(use-package dap-mode)
