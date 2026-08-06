;;; vterm-config.el --- Description -*- lexical-binding: t; -*-

(use-package vterm
  :hook
  ((vterm-mode . (lambda ()
                  (setq-local confirm-kill-processes nil
                              mode-line-format nil)))
   (vterm-copy-mode . (lambda ()
                        (if vterm-copy-mode
                            (meow-normal-mode 1)
                          (meow-insert-mode 1)))))
  :init
  (setq vterm-timer-delay 0.05
		vterm-max-scrollback 5000)
  :config
  (setq vterm-buffer-name-string "vterm %s"))

(defun om/vterm ()
  "Open vterm buffer as a bottom popup at 30% height."
  (interactive)
  (require 'vterm)
  (let* ((buf (get-buffer-create "*vterm*"))
         (win (get-buffer-window buf 'visible)))
    (if (eq win (selected-window))
        ;; Case 1: We are already inside the vterm window -> Hide it!
        (window-toggle-side-windows)
      ;; Case 2: The terminal is hidden or out of focus -> Open/Focus it
      (with-current-buffer buf
        (unless (derived-mode-p 'vterm-mode)
          (vterm-mode)))
      (select-window
       (display-buffer
        buf
        '((display-buffer-reuse-window
           display-buffer-in-side-window)
          (side . bottom)
          (slot . 0)
          (window-height . 0.3)
          (window-parameters . ((no-delete-other-windows . t)))))))))

(provide 'vterm-config)
;;; vterm-config.el ends here
