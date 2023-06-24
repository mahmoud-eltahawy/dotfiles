;;; dev.el --- Description -*- lexical-binding: t; -*-

(electric-pair-mode 1)

(use-package tree-sitter-langs)
(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package lsp-ui
  :commands lsp-ui-mode
  :custom
    (lsp-ui-peek-always-show t)
    (lsp-ui-sideline-show-hover t))

(use-package helm-lsp :commands helm-lsp-workspace-symbol)
(use-package ivy
  :config
    (ivy-mode 1))
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package treemacs)
(use-package lsp-treemacs
  :after lsp
  :commands lsp-treemacs-errors-list)

(load (mt-path "dev/auto-complete.el"))

(load (mt-path "dev/rust.el"))
(load (mt-path "dev/ts.el"))
(load (mt-path "dev/lsp.el"))


(use-package nix-mode
  :mode "\\.nix\\'")

(use-package haskell-mode)

;;; Debug
(use-package dap-mode)
