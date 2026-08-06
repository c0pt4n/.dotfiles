;;; completion.el --- completion stack -*- lexical-binding: t; -*-

(use-package vertico
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t))

(use-package marginalia
  :init
  (marginalia-mode 1))

(elpaca-wait)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind
  (("C-x b"   . consult-buffer)
   ("M-g g"   . consult-goto-line)
   ("C-x C-f" . consult-find)
   ("M-s l" . consult-line)
   ("C-x m" . consult-man))
  :config
  (consult-customize
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file
   :preview-key '(:debounce 0.4 any)))

(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)))

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package nerd-icons-completion
  :init
  (nerd-icons-completion-mode))

(use-package corfu
  :custom
  (corfu-auto        t)
  (corfu-auto-delay  0)
  (corfu-preview-current t)
  (corfu-auto-prefix 1)
  (corfu-cycle       t)
  (corfu-quit-no-match t)
  :config
  (corfu-popupinfo-mode)
  :init
  (global-corfu-mode))

;; remove ispell word completion
(setq text-mode-ispell-word-completion nil)

;; Global fallback capfs for non-eglot buffers.
;; eglot-managed buffers get their own stack rebuilt in grammars.el.
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block))

(provide 'completion)
;;; completion.el ends here
