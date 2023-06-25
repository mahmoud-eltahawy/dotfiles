;;; auto-complete.el --- Description -*- lexical-binding: t; -*-

(use-package yasnippet
  :config
    (yas-reload-all)
    (add-hook 'prog-mode-hook 'yas-minor-mode)
    (add-hook 'text-mode-hook 'yas-minor-mode))

(defun company-yasnippet-or-completion ()
   (interactive)
   (or (do-yas-expand)
       (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas-fallback-behavior 'return-nil))
    (yas-expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas-minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

(use-package company
  :hook (prog-mode . company-mode)
  :config
    (add-hook 'after-init-hook 'global-company-mode)
  :custom
    (company-idle-delay 0.0) ;; how long to wait until popup
    (company-minimum-prefix-length 1) ;; how many letters to wait until popup
  :bind
    (:map company-active-map
        ("<tab>" . company-complete-selection)
	("C-n". company-select-next)
	("C-p". company-select-previous)
	("M-<". company-select-first)
	("M->". company-select-last))
    (:map company-mode-map
        ("<tab>". tab-indent-or-complete)
        ("TAB". tab-indent-or-complete)))

(use-package company-box
  :hook (company-mode . company-box-mode))
