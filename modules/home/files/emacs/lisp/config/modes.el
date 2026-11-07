;;; -*- lexical-binding: t; -*-

(use-package paren
  :ensure nil
  :init
  (setq show-paren-delay 0
		show-paren-when-point-inside-paren t
		show-paren-when-point-in-periphery t))

(use-package python
  :ensure nil
  :custom
  (python-indent-guess-indent-offset nil)
  (python-indent-offset 4))

(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode)))

(use-package nix-mode)

(use-package ediff
  :ensure nil
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain
		ediff-split-window-function 'split-window-horizontally))

(use-package rainbow-mode
  :hook ((prog-mode . rainbow-mode)
		 (emacs-lisp-mode . rainbow-mode)
		 (org-mode . rainbow-mode)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'config/modes)
