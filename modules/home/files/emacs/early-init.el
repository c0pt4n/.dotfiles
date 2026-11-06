;;; -*- lexical-binding: t; -*-

(setq package-enable-at-startup nil)
(setopt inhibit-startup-screen t
        initial-scratch-message nil
        native-comp-async-report-warnings-errors 'silent
        line-spacing 0.12
        use-file-dialog nil
        use-dialog-box nil
        cursor-type 'box
        cursor-in-non-selected-windows nil)

(add-to-list 'default-frame-alist '(alpha-background . 90))

;;; UI
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(menu-bar-mode -1)

;; UTF-8
(set-language-environment "UTF-8")
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; Fonts
(set-face-attribute 'default nil :family "monospace" :height 120)
(set-face-attribute 'fixed-pitch nil :family "monospace")
(set-face-attribute 'variable-pitch nil :family "sans-serif")
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

(set-face-attribute 'mouse nil :background "#ffffcc" :inherit 'highlight)
(set-fontset-font t 'emoji (font-spec :family "emoji") nil 'prepend)
