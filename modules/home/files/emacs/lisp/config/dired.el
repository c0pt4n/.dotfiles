;;; -*- lexical-binding: t; -*-

(use-package dired
  :ensure nil
  :hook
  (dired-mode . auto-revert-mode)
  :custom
  (dired-listing-switches "-lAh --group-directories-first --no-group")
  (dired-recursive-copies 'always)
  (dired-dwim-target t)
  (dired-clean-confirm-killing-deleted-buffers nil)
  (dired-kill-when-opening-new-dired-buffer t)
  (global-auto-revert-non-file-buffers t)
  (dired-auto-revert-buffer t)
  (auto-revert-verbose nil))

(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :config
  (add-hook 'dirvish-special-preview-mode-hook
            (lambda () (setq-local show-trailing-whitespace nil)))
  :custom
  (dirvish-attributes '(nerd-icons subtree-state file-size))
  (dirvish-use-mode-line nil)
  (dirvish-use-header-line t)
  (dirvish-header-line-format '(:left (path) :right (free-space)))
  (dirvish-hide-details '(dirvish))
  (dirvish-reuse-session nil)
  (dirvish-preview-dispatchers '(image gif video audio epub archive pdf)))

(provide 'config/dired)
