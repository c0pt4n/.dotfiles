;;; editing.el --- Description -*- lexical-binding: t; -*-

;; fix <> closing automatically in org-mode
(with-eval-after-load 'org
  (add-hook 'org-mode-hook
            (lambda ()
              (setq-local electric-pair-inhibit-predicate
                          (lambda (c)
                            (if (char-equal c ?<)
                                t
                              (electric-pair-conservative-inhibit c)))))))

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

(provide 'editing)
;;; editing.el ends here
