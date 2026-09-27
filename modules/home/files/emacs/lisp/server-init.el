;;; server-init.el --- Start emacs server if not running -*- lexical-binding: t; -*-

(use-package server
  :ensure nil
  :bind ("C-c r" . (lambda () (interactive) (load-file user-init-file)))
  :hook (after-init . server-start))

(provide 'server-init)
;;; server-init.el ends here
