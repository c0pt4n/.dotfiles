;;; magit-config.el --- Git integration -*- lexical-binding: t; -*-

(use-package magit-section)
(elpaca-wait)

(use-package magit
  :hook (git-commit-mode . meow-insert)
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1
        magit-bury-buffer-function #'magit-restore-window-configuration)
  (define-key magit-status-mode-map (kbd "p") #'magit-push)
  (define-key magit-status-mode-map (kbd "SPC") nil)
  (define-key magit-log-mode-map (kbd "SPC") nil)
  (define-key magit-diff-mode-map (kbd "SPC") nil))

(use-package git-gutter
  :init
  (global-git-gutter-mode 1)
  :custom
  (git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(use-package git-modes
  :mode (("/\\.gitignore\\'" . gitignore-mode)
         ("/\\.gitconfig\\'" . gitconfig-mode)
         ("/\\.gitattributes\\'" . gitattributes-mode)))

(provide 'magit-config)
;;; magit-config.el ends here
