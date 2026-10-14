;;; -*- lexical-binding: t; -*-

(use-package python
  :ensure nil
  :custom
  (python-indent-guess-indent-offset nil)
  (python-indent-offset 4))

(use-package rainbow-mode
  :hook ((prog-mode . rainbow-mode)
		 (emacs-lisp-mode . rainbow-mode)
		 (org-mode . rainbow-mode)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ediff
  :ensure nil
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain
		ediff-split-window-function 'split-window-horizontally))

(provide 'config/editing)
