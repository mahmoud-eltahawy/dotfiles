(defun load_from_home (name)
  "load emacs file from ~/magit/dotfiles/emacs directory"
  (load 
    (concat "~/magit/dotfiles/emacs/" name ".lisp") nil t))

(load_from_home "init")
