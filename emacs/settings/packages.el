;;; packages.el --- Description -*- lexical-binding: t; -*-

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

(package-initialize)
(package-refresh-contents)

(defconst mt/packages
  '(org-superstar
    beacon
    marginalia
    envrc
    vertico
    yaml-mode
    nix-mode
    which-key
    general
    company-box
    evil
    magit
    dap-mode
    company
    yasnippet
    org-auto-tangle
    counsel
    all-the-icons
    nerd-icons-dired
    ligature
    evil-surround))

(dolist (x mt/packages)
  (unless (package-installed-p x)
    (package-install x)))

