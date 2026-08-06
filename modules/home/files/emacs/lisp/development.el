;;; development.el -- Coding stack -*- lexical-binding: t; -*-

(use-package treesit
  :ensure nil
  :init
  (setq major-mode-remap-alist
		'((c-mode          . c-ts-mode)
		  (go-mode         . go-ts-mode)
		  (sh-mode         . bash-ts-mode)
		  (html-mode       . html-ts-mode)
		  (json-mode       . json-ts-mode)
		  (python-mode     . python-ts-mode)
		  (yaml-mode       . yaml-ts-mode)
		  (javascript-mode . js-ts-mode)
		  (dockerfile-mode . dockerfile-ts-mode)
		  (nix-mode        . nix-ts-mode)))
  (setq treesit-language-source-alist
		'((c           "https://github.com/tree-sitter/tree-sitter-c" "v0.21.3")
		  (go          "https://github.com/tree-sitter/tree-sitter-go" "v0.23.4")
		  (gomod       "https://github.com/camdencheek/tree-sitter-go-mod" "v1.1.0")
		  (bash        "https://github.com/tree-sitter/tree-sitter-bash" "v0.23.3")
		  (html        "https://github.com/tree-sitter/tree-sitter-html")
		  (json        "https://github.com/tree-sitter/tree-sitter-json")
		  (yaml        "https://github.com/ikatyang/tree-sitter-yaml")
		  (python      "https://github.com/tree-sitter/tree-sitter-python" "v0.23.6")
		  (javascript  "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
		  (dockerfile  "https://github.com/camdencheek/tree-sitter-dockerfile")
		  (nix "https://github.com/nix-community/tree-sitter-nix")))
  (dolist (entry '(("\\.go\\'"     . go-ts-mode)
                   ("go\\.mod\\'"  . go-mod-ts-mode)
                   ("go\\.sum\\'"  . go-mod-ts-mode)
                   ("\\.c\\'"      . c-ts-mode)
                   ("\\.h\\'"      . c-ts-mode)
				   ("[Dd]ockerfile\\'" . dockerfile-ts-mode)))
	(add-to-list 'auto-mode-alist entry)))

(use-package nix-ts-mode
  :mode "\\.nix\\'")

;; YASNIPPET
;; No :defer — yas-global-mode must be live before the first eglot buffer
;; opens or yasnippet-capf serves nothing on first completion attempt.
(use-package yasnippet
  :demand t
  :config
  (setq yas-snippet-dirs '("~/.config/emacs/snippets")
        yas-verbosity    0)
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :demand t
  :after yasnippet)

(use-package yasnippet-capf
  :demand t
  :custom
  (yasnippet-capf-lookup-by 'key))

(elpaca-wait)

(add-hook 'org-mode-hook
          (lambda ()
            (setq-local completion-at-point-functions
                        (list #'yasnippet-capf
                              #'cape-dabbrev
                              #'cape-file
                              #'pcomplete-completions-at-point
                              #'ispell-completion-at-point))))

;; See go-mode snippets
(add-hook 'go-ts-mode-hook #'(lambda () (yas-activate-extra-mode 'go-mode)))

;; EGLOT
(use-package eglot
  :ensure nil
  :hook ((go-ts-mode     . eglot-ensure)
         (bash-ts-mode   . eglot-ensure)
         (json-ts-mode   . eglot-ensure)
         (yaml-ts-mode   . eglot-ensure)
         (python-ts-mode . eglot-ensure)
         (js-ts-mode     . eglot-ensure)
         (html-ts-mode   . eglot-ensure)
         (c-ts-mode      . eglot-ensure)
         (dockerfile-ts-mode      . eglot-ensure)
		 (nix-ts-mode    . eglot-ensure))
  :custom
  (eglot-autoshutdown       t)
  (eglot-events-buffer-size 0)
  (eglot-sync-connect       nil)
  (eglot-extend-to-xref     t))

(provide 'development)
;;; development.el ends here
