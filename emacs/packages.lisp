(require 'package)

(if (getenv "EMACS_INSTALL")
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)
  (package-refresh-contents)

  (unless (package-installed-p 'evil)
    (package-install 'evil)))
