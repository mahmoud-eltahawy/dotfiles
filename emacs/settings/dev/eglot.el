(use-package eglot
  :config
    (add-hook 'haskell-mode-hook #'eglot-ensure)
    (add-hook 'rust-mode-hook #'eglot-ensure)
    (add-hook 'eglot-managed-mode-hook (lambda () (flymake-mode -1))))

(setq tab-always-indent 'complete
      completions-max-height 20
      completion-auto-select 'second-tab)
