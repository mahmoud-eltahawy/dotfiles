;;; keys.el --- Description -*- lexical-binding: t; -*-

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

  "t"  '(:ignore t :which-key "toggles")
  "tt" '(counsel-load-theme :which-key "choose theme")

  "k"  '(:ignore k :which-key "basic keys")
  "kk" '(kill-buffer :which-key "kill buffer")

  "g"  '(:ignore g :which-key "magit")
  "gg" '(magit-status :which-key "magit status")

  "f"  '(:ignore f :which-key "files")
  "ff"  '(find-file :which-key "find file"))
