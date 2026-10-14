;;; -*- lexical-binding: t; -*-

(use-package server
  :ensure nil
  :demand t
  :bind ("C-c r" . (lambda () (interactive) (load-file user-init-file)))
  :config
  (unless (server-running-p)
    (server-start)))

(provide 'config/server-init)
