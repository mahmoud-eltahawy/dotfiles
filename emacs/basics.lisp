(menu-bar-mode -1) 
(scroll-bar-mode -1) 
(tool-bar-mode -1) 
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(setq split-width-threshold 0)
(setq split-window-default 'vertical)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq-default indent-tabs-mode nil)

(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))
