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

(defun start-work-session ()
  (interactive)
  (org-timer-set-timer 20))

(defun start-rest-session ()
  (interactive)
  (org-timer-set-timer 5))

(mt/keys
  "p"  'counsel-M-x
  "."  'dired
  "b"  'switch-to-buffer

  "t"  '(:ignore t :which-key "time sessions")
  "tw" '(start-work-session :which-key "work session")
  "tr" '(start-rest-session :which-key "rest session")
  "te" '(org-timer-stop :which-key "end session")

  "k"  '(:ignore k :which-key "basic keys")
  "kk" '(kill-buffer :which-key "kill buffer")

  "g"  '(:ignore g :which-key "magit")
  "gg" '(magit-status :which-key "magit status")

  "l"  '(:ignore l :which-key "eglot language server")
  "ls" '(eglot :which-key "eglot start")
  "la" '(eglot-code-actions :which-key "eglot code actions")
  "lr" '(eglot-rename :which-key "eglot rename")
  "lq" '(eglot-reconnect :which-key "eglot reconnect")
  "lQ" '(eglot-shutdown :which-key "eglot shutdown")
  "lf" '(eglot-format :which-key "eglot format")

  "f"  '(:ignore f :which-key "files")
  "ff" '(find-file :which-key "find file")
  "fu" '(sudo-find-file :which-key "sudo find file"))

(evil-define-key 'normal 'evil-org-mode-map "<tab>" #'org-force-cycle-archived)
(define-key evil-visual-state-map (kbd "g c") 'comment-dwim)
(define-key evil-normal-state-map (kbd "g c") 'comment-line)

(define-key evil-normal-state-map (kbd "C-r") 'undo-redo)
(define-key evil-insert-state-map (kbd "C-r") 'undo-redo)
