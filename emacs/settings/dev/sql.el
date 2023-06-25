
(defun my-possibly-setup-pgdump-outline nil
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (forward-line 1)
    (when (looking-at "-- PostgreSQL database dump")
      (set (make-local-variable 'outline-regexp)
	   "-- \\(Data for \\)?Name:")
      (set (make-local-variable 'outline-level)
	   (lambda nil 1))
      (outline-minor-mode 1)
      (hide-sublevels 1))))

(add-hook 'sql-mode-hook 'my-possibly-setup-pgdump-outline)
