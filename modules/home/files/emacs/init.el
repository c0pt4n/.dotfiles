;;; init.el -*- lexical-binding: t; -*-

(setq user-full-name "Omar Mohamed"
      user-mail-address "omarcoptan9@gmail.com")

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
(elpaca cond-let)
(elpaca compat)
(elpaca-wait)
(elpaca transient)
(elpaca-wait)

(setq use-package-always-defer t
      use-package-always-ensure t
      ;; Testing for package timing
      ;; use-package-compute-statistics t
      use-package-expand-minimally t)

(setq custom-file (expand-file-name "etc/custom.el" user-emacs-directory))

(use-package no-littering
  :demand t
  :init
  (setq no-littering-etc-directory (expand-file-name "etc/" user-emacs-directory)
		no-littering-var-directory "~/.local/share/emacs/"))
(elpaca-wait)

(when (file-exists-p custom-file)
  (load custom-file))

(use-package gcmh
  :config
  (setq gcmh-idle-delay 5
		gcmh-high-cons-threshold (* 16 1024 1024))
  (gcmh-mode 1))

(blink-cursor-mode -1)
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))
(electric-pair-mode 1)
(save-place-mode 1)
(global-hl-line-mode 1)
(column-number-mode 1)
(global-auto-revert-mode 1)

(setq scroll-margin 2
	  display-line-numbers-type 'relative
	  make-backup-files nil
	  auto-save-default nil
	  create-lockfiles nil
	  initial-scratch-message nil
	  require-final-newline t
	  native-comp-async-report-warnings-errors 'silent ;; Native Comp
	  use-short-answers t)

(setq tab-always-indent 'complete)
(setq-default truncate-lines t
			  indent-tabs-mode nil
			  tab-width 4
			  save-interprogram-paste-before-kill t)
(add-hook 'before-save-hook #'delete-trailing-whitespace)

(use-package which-key
  :ensure nil
  :demand t
  :config
  (setq which-key-idle-delay 0.1)
  (which-key-mode 1))

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

(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/custom/" user-emacs-directory))

(require 'meow-config)
(require 'flash-config)
(require 'dashboard)
(require 'modeline)
(require 'dired-setup)
(require 'vterm-config)
(require 'org-config)
(require 'theme)
(require 'magit-config)
(require 'completion)
(require 'editing)
(require 'development)
(require 'persist)
(require 'markdown)
(require 'tramp-config)
(require 'everywhere)
(require 'move-text-config)
;; (require 'workspaces)
(require 'emms-config)

(when (eq system-type 'gnu/linux)
  (require 'pdf-setup)
  (require 'pass-config)
  (require 'llms)
  ;; Custom
  (require 'om-clipboard-manager))
