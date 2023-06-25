;;; packages.el --- Description -*- lexical-binding: t; -*-

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

(package-initialize)
(package-refresh-contents)

(defconst mt/packages
  '(emacs-everywhere
    org-superstar
    beacon
    marginalia
    envrc
    haskell-mode
    vertico
    yaml-mode
    nix-mode
    which-key
    general
    typescript-mode
    company-box
    evil
    magit
    dap-mode
    rust-mode
    company
    yasnippet
    org-auto-tangle
    doom-modeline
    counsel
    all-the-icons
    nerd-icons-dired
    doom-themes
    ligature
    evil-surround))

(dolist (x mt/packages)
  (unless (package-installed-p x)
    (package-install x)))

