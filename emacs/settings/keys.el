;;; keys.el --- Description -*- lexical-binding: t; -*-

(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

(use-package evil
  :config
  (evil-mode 1))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package which-key
  :config
  (which-key-mode))

(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer mt/keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

(mt/keys
  ";"  'counsel-M-x
  "."  'dired
  "b"  'switch-to-buffer

  "t"  '(:ignore t :which-key "toggles")
  "tt" '(counsel-load-theme :which-key "choose theme")

  "k"  '(:ignore k :which-key "basic keys")
  "kk" '(kill-buffer :which-key "kill buffer")

  "g"  '(:ignore g :which-key "magit")
  "gg" '(magit-status :which-key "magit status")

  "f"  '(:ignore f :which-key "files")
  "ff" '(find-file :which-key "find file")
  "fu" '(sudo-find-file :which-key "sudo find file"))

(define-key evil-visual-state-map (kbd "g c") 'comment-dwim)
(define-key evil-normal-state-map (kbd "g c") 'comment-line)
