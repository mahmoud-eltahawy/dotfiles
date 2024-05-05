(cl-defmethod project-root ((project (head eglot-project)))
  (cdr project))

(defun my-project-try-tsconfig-json (dir)
  (when-let* ((found (locate-dominating-file dir "tsconfig.json")))
    (cons 'eglot-project found)))

(add-hook 'project-find-functions
          'my-project-try-tsconfig-json nil nil)

(add-to-list 'eglot-server-programs
             '((typescript-mode) "typescript-language-server" "--stdio"))
