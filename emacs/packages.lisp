(require 'package)

(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

; (if (equal (getenv "EMACS_INSTALL") nil)
  (package-initialize)
  (package-refresh-contents)

  (defconst mt/packages
    '(flycheck
      typescript-mode
      csharp-mode
      company
      yasnippet      
      all-the-icons
      nerd-icons-dired
      general
      which-key
      ligature
      evil
      vertico
      marginalia
      evil-surround))
  
  (dolist (x mt/packages)
    (unless (package-installed-p x)
      (package-install x)))
  ; )
