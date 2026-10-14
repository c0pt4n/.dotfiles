;;; -*- lexical-binding: t; -*-

(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  (elpaca-use-package-mode))
(elpaca-wait)
(elpaca transient)
(elpaca-wait)

(setq use-package-always-defer t
      use-package-always-ensure t
      vc-follow-symlinks t
      ;; Testing for package timing
      ;; use-package-compute-statistics t
      use-package-expand-minimally t)

(setq custom-file (expand-file-name "etc/custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))

(setopt display-fill-column-indicator-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))

(electric-pair-mode 1)
(save-place-mode 1)
(global-hl-line-mode 1)
(column-number-mode 1)
(global-auto-revert-mode 1)
(set-fringe-mode 10)
(blink-cursor-mode -1)

(setopt scroll-margin 2
        display-line-numbers-type 'relative
        make-backup-files nil
        auto-save-default nil
        create-lockfiles nil
        require-final-newline t
        indicate-empty-lines t
        kill-do-not-save-duplicates t
        window-combination-resize t
        use-short-answers t)

(setopt select-enable-primary t
        select-enable-clipboard nil)

(keymap-global-set "C-S-p" (lambda ()
                             (interactive)
                             (clipboard-yank)))
(keymap-global-set "C-S-y" (lambda ()
                             (interactive)
                             (clipboard-kill-ring-save
                              (region-beginning)
                              (region-end))))

(use-package gcmh
  :init
  (setopt native-comp-jit-compilation t
          gc-cons-threshold (* 10 1024 1024)
          read-process-output-max (* 4 1024 1024)
          redisplay-skip-fontification-on-input t)
  :config
  (setq gcmh-idle-delay 5
		gcmh-high-cons-threshold (* 16 1024 1024))
  (gcmh-mode 1))

(use-package no-littering
  :demand t
  :init
  (setopt no-littering-etc-directory (expand-file-name "etc/" user-emacs-directory)
          no-littering-var-directory "~/.local/share/emacs/"))
(elpaca-wait)

(use-package paren
  :ensure nil
  :init
  (setq show-paren-delay 0
		show-paren-when-point-inside-paren t
		show-paren-when-point-in-periphery t))

(use-package which-key
  :ensure nil
  :demand t
  :config
  (setopt which-key-idle-delay 0.3)
  (which-key-mode 1))

(use-package winner
  :ensure nil
  :demand t
  :init
  (setq winner-dont-bind-my-keys t)
  :config
  (winner-mode 1))

(use-package recentf
  :ensure nil
  :init
  (recentf-mode 1)
  :config
  (setq recentf-max-menu-items 25
		recentf-max-saved-items 100)
  (dolist (path '("\\.git/" "/tmp/" "/nix/store/" "\\.gpg/"))
	(add-to-list 'recentf-exclude path))
  (add-to-list 'recentf-exclude (recentf-expand-file-name no-littering-var-directory))
  (add-to-list 'recentf-exclude (recentf-expand-file-name no-littering-etc-directory))
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

(use-package savehist
  :ensure nil
  :init
  (savehist-mode 1)
  :config
  (setq history-length 1000
		history-delete-duplicates t
		savehist-save-minibuffer-history t)
  (dolist (var '(extended-command-history
				 search-ring
				 regexp-search-ring
				 consult--buffer-history
				 recentf-list))
	(add-to-list 'savehist-additional-variables var)))

(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))

(require 'config/modal)
(require 'config/complete)
(require 'config/undo)
(require 'config/dired)
(require 'config/term)
(require 'config/org)
(require 'config/git)
(require 'config/theme)
(require 'config/editing)
(require 'config/lsp)
(require 'config/treesitter)
(require 'config/format)
(require 'config/snippets)
(require 'config/persist)
(require 'config/markdown)
(require 'config/tramp)
(require 'config/everywhere)
(require 'config/emms)
(require 'config/server-init)

(when (eq system-type 'gnu/linux)
  ;; (require 'config/email)
  (require 'config/pdf)
  (require 'config/pass)
  (require 'config/llms)
  (require 'config/agentshell))
