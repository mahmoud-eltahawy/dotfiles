;;; rust.el --- Description -*- lexical-binding: t; -*-

(use-package rust-mode
  :hook (rust-mode . lsp-deferred))

(defun mt/rustic-mode-hook ()
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

(use-package rustic
  :bind
    (:map rustic-mode-map
       ("M-j" . lsp-ui-imenu)
       ("M-?" . lsp-find-references)
       ("C-c C-c l" . flycheck-list-errors)
       ("C-c C-c a" . lsp-execute-code-action)
       ("C-c C-c r" . lsp-rename)
       ("C-c C-c q" . lsp-workspace-restart)
       ("C-c C-c Q" . lsp-workspace-shutdown)
       ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
    ;; (setq lsp-eldoc-hook nil)
    ;; (setq lsp-enable-symbol-highlighting nil)
    ;; (setq lsp-signature-auto-activate nil)

    (setq rustic-format-on-save t)
    (add-hook 'rustic-mode-hook 'mt/rustic-mode-hook))
