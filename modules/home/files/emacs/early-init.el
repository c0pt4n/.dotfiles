;;; early-init.el --- Description -*- lexical-binding: t; -*-

(setq package-enable-at-startup nil)

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
(set-face-attribute 'default nil
					:family "monospace"
					:height 130
					:weight 'regular)
(set-face-attribute 'variable-pitch nil
					:family "monospace"
					:height 140
					:weight 'regular)
(set-face-attribute 'fixed-pitch nil
					:family "monospace"
					:height 130
					:weight 'regular)

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "monospace-13"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)
(set-face-background 'mouse "#ffffff")

(setq native-comp-async-report-warnings-errors 'silent)
;;; early-init.el ends here
