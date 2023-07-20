(use-package eglot
  :config
    (add-hook 'haskell-mode-hook #'eglot-ensure)
    (add-hook 'eglot-managed-mode-hook (lambda ()
					 (eglot-inlay-hints-mode -1)
					 (flymake-mode -1))))

(setq tab-always-indent 'complete
      completions-max-height 20
      completion-auto-select 'second-tab)
