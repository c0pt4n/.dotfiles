;;; -*- lexical-binding: t; -*-

(use-package yasnippet
  :demand t
  :config
  (setopt yas-verbosity 0)
  (let ((dir (expand-file-name "snippets/" "~/.local/share/emacs/")))
    (unless (file-directory-p dir)
      (make-directory dir t))
    (setopt yas-snippet-dirs (list dir)))
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :demand t
  :after yasnippet
  :config
  (yasnippet-snippets-initialize))

(use-package yasnippet-capf
  :demand t
  :custom
  (yasnippet-capf-lookup-by 'key))

(add-hook 'go-ts-mode-hook #'(lambda () (yas-activate-extra-mode 'go-mode)))

(provide 'config/snippets)
