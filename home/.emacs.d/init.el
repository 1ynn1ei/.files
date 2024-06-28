(package-initialize)

(org-babel-load-file
 (expand-file-name
  "README.org"
  user-emacs-directory))
(put 'dired-find-alternate-file 'disabled nil)
