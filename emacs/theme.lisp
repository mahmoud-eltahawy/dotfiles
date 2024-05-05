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

;;opacity
(set-frame-parameter nil 'alpha-background 70)
(add-to-list 'default-frame-alist '(alpha-background . 70))
