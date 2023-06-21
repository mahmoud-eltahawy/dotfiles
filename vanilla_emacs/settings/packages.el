;;; packages.el --- Description -*- lexical-binding: t; -*-

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

(package-initialize)
(package-refresh-contents)

(defconst mt/packages
  '(which-key
    general
    python-mode
    pyenv-mode
    typescript-mode
    company-box
    use-package
    evil
    magit
    dap-mode
    lsp-mode
    rust-mode
    flycheck
    company
    yasnippet
    org-auto-tangle
    tree-sitter
    doom-modeline
    ivy
    ivy-rich
    counsel
    tree-sitter-langs
    lsp-ui
    all-the-icons
    nerd-icons-dired
    nerd-icons-ivy-rich
    doom-themes ligature
    evil-surround))

(dolist (x mt/packages)
  (unless (package-installed-p x)
    (package-install x)))
