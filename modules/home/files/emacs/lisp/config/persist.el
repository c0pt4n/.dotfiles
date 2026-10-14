;;; -*- lexical-binding: t; -*-

(use-package persistent-scratch
  :demand t
  :custom
  (persistent-scratch-save-file (expand-file-name "persistent-scratch" no-littering-var-directory))
  (persistent-scratch-autosave-interval 60)
  (persistent-scratch-what-to-save '(major-mode point narrowing))
  :config
  (persistent-scratch-setup-default)
  (persistent-scratch-autosave-mode 1))

(use-package perspective
  :bind
  ("C-x C-b" . persp-list-buffers)
  :custom
  (persp-mode-prefix-key (kbd "C-c C-p"))
  :init
  (persp-mode))

(provide 'config/persist)
