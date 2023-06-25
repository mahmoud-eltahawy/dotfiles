;;; rust.el --- Description -*- lexical-binding: t; -*-

(use-package rust-mode)

(use-package rustic
  :after rust-mode-hook)

(setq lsp-rust-analyzer-cargo-watch-command "clippy")
