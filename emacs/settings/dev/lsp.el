;;; lsp.el --- Description -*- lexical-binding: t; -*-

(use-package lsp-mode
  :init
    (setq lsp-keymap-prefix "C-c l")
  :hook
    ((lsp-mode . mt/lsp-mode-setup)
     (lsp-mode . lsp-ui-mode)
     (lsp-mode . lsp-enable-which-key-integration))
  :custom
     (lsp-rust-analyzer-cargo-watch-command "clippy") ;; check or clippy
     ;; (lsp-eldoc-render-all t)
     (lsp-idle-delay 0.6)
     ;; rust analyzer hints:
     (lsp-rust-analyzer-server-display-inlay-hints t)
     (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
     (lsp-rust-analyzer-display-chaining-hints t)
     (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
     (lsp-rust-analyzer-display-closure-return-type-hints t)
     (lsp-rust-analyzer-display-parameter-hints nil)
     (lsp-rust-analyzer-display-reborrow-hints nil)
  :commands (lsp lsp-deferred))

(add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))
