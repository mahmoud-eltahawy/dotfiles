;;; emacs.el --- Description -*- lexical-binding: t; -*-

(defun mt-path (name) (concat "~/magit/dotfiles/emacs/" name))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(load (mt-path "epm.el"))
(setq use-package-always-ensure t)
(load (mt-path "look.el"))
(load (mt-path "keys.el"))
(load (mt-path "org.el"))
(load (mt-path "rust.el"))
(load (mt-path "completion.el"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-surround ligature nerd-icons-dired all-the-icons counsel org-auto-tangle yasnippet dap-mode magit evil company-box general which-key nix-mode yaml-mode vertico envrc marginalia beacon flycheck rust-mode org-superstar)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
