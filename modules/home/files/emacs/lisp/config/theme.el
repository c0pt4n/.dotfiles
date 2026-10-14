;;; -*- lexical-binding: t; -*-

(use-package nerd-icons
  :demand t)

(use-package doom-themes
  :demand t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (if (daemonp)
      (cl-labels ((load-nord (frame)
                    (with-selected-frame frame
                      (load-theme 'doom-nord t))
                    (remove-hook 'after-make-frame-functions #'load-nord)))
        (add-hook 'after-make-frame-functions #'load-nord))
    (load-theme 'doom-nord t)))

(use-package doom-modeline
  :demand t
  :init
  (setq doom-modeline-icon t)
  :config
  (doom-modeline-mode 1))

(provide 'config/theme)
