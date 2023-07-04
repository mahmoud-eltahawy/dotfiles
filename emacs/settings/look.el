;;; look.el --- Description -*- lexical-binding: t; -*-

(setq split-width-threshold 0)
(setq split-window-default 'vertical)

(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 77)

(global-display-line-numbers-mode 1)
(beacon-mode 1)
(setq display-line-numbers-type 'relative)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

(add-to-list 'default-frame-alist '(font . "Firacode 14"))

(setq
 modus-themes-mode-line '(accented borderless padded)
 modus-themes-region '(bg-only no-extend)
 modus-themes-bold-constructs t
 modus-themes-italic-constructs t
 modus-themes-fringes 'subtle
 modus-themes-prompts '(bold intense)
 modus-themes-tabs-accented t
 modus-themes-scale-headings t
 modus-themes-paren-match '(bold intense)
 modus-themes-syntax '(alt-syntax green-strings yellow-comments)
 modus-themes-org-blocks 'tinted-background
 modus-themes-headings
      '((1 . (rainbow overline background 1.6))
        (2 . (rainbow background 1.4))
        (3 . (rainbow bold 1.2))
        (t . (semilight 1.0))))

(load-theme 'modus-vivendi t)

;; fullscreen an opacity
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))


(use-package ligature
  :config
    ;; Enable the www ligature in every possible major mode
    (ligature-set-ligatures 't '("www"))

    ;; Enable ligatures in programming modes
    (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
					":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
					"-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
					"#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
					"/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
					"++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
					"=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
					"<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
					"<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
					"<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))

    (global-ligature-mode 't))

(use-package nerd-icons
   :custom
   (nerd-icons-font-family "Symbols Nerd Font Mono"))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package vertico
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package emacs-everywhere)
