;;; modeline.el -*- lexical-binding: t; -*-

(use-package nerd-icons :demand t)

(elpaca-wait)

(use-package doom-modeline
  :demand t
  :init
  (setq doom-modeline-icon t)
  :config
  (doom-modeline-mode 1))

(provide 'modeline)
;;; modeline.el ends here
