;;; theme.el --- theme setup -*- lexical-binding: t; -*-

(use-package nordic-night-theme)
(use-package nord-theme)
(use-package tron-legacy-theme)

(defun oceanic/theme-load ()
  (load-theme 'nordic-midnight t))

(if (daemonp)
    (add-hook 'server-after-make-frame-hook #'oceanic/theme-load)
  (oceanic/theme-load))

(provide 'theme)
;;; theme.el ends here
