;;; dashboard-config.el --- Startup dashboard -*- lexical-binding: t; -*-

(elpaca-wait)

(use-package dashboard
  :after nerd-icons
  :demand t
  :init
  (setq dashboard-banner-logo-title "Oceanic Emacs"
        dashboard-startup-banner 'logo
        dashboard-show-shortcuts nil)
  :config
  (setq dashboard-display-icons-p t
        dashboard-icon-type 'nerd-icons
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-items '((recents   . 5)
                          (bookmarks . 5)
                          (projects  . 5)
                          (agenda    . 5)))
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (add-hook 'easysession-after-load-hook
            (lambda ()
              (dashboard-refresh-buffer)
              (switch-to-buffer dashboard-buffer-name)))
  (dashboard-setup-startup-hook)

  ;; For emacsclient - show dashboard when connecting without a file
  (add-hook 'server-after-make-frame-hook
			(lambda ()
			  (when (and (not (buffer-file-name))
						 (member (buffer-name) '("*scratch*" " *server*")))
				(dashboard-refresh-buffer)
				(switch-to-buffer dashboard-buffer-name))))

  ;; For regular Emacs startup
  (add-hook 'emacs-startup-hook
			(lambda ()
			  (when (< (length command-line-args) 2)
				(dashboard-refresh-buffer)
				(switch-to-buffer dashboard-buffer-name)))))

(use-package page-break-lines
  :after dashboard)

(provide 'dashboard-config)
;;; dashboard-config.el ends here
