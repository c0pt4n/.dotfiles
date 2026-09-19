;;; theme.el --- Nord theme -*- lexical-binding: t; -*-

(defun om/theme-init-daemon ()
  (load-theme 'nordic-night t)
  (remove-hook 'server-after-make-frame-hook #'om/theme-init-daemon)
  (fmakunbound 'om/theme-init-daemon))

(use-package nordic-night-theme
  :init
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'om/theme-init-daemon)
    (load-theme 'nordic-night t)))

(provide 'theme)
;;; theme.el ends here