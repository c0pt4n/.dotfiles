;;; -*- lexical-binding: t; -*-

(use-package undo-tree
  :demand t
  :config
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(expand-file-name "undo-tree-history" no-littering-var-directory))))
  (global-undo-tree-mode 1))

(provide 'config/undo)
