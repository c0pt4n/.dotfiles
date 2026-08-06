;;; pass-config.el --- password-store in Emacs -*- lexical-binding: t; -*-

(use-package pass
  :bind (:map pass-mode-map
              ("W" . pass-copy-field))
  :config
  (add-to-list 'display-buffer-alist
               '("\\*Password-Store\\*"
				 (display-buffer-in-side-window)
				 (side . left)
				 (window-width . 0.25)
				 (window-parameters . ((no-other-window . nil)))
				 (inhibit-same-window . t))))

(provide 'pass-config)
;;; pass-config.el ends here
