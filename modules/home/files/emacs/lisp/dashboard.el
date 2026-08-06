;;; dashboard.el --- Startup dashboard -*- lexical-binding: t; -*-

(defconst om-dashboard-buffer "*dashboard*")

(defun om-dashboard--load-time ()
  (float-time (time-subtract after-init-time before-init-time)))

(defun om-dashboard-render ()
  (interactive)
  (let ((buf (get-buffer-create om-dashboard-buffer)))
    (with-current-buffer buf
      (let* ((inhibit-read-only t)
             (win (get-buffer-window buf t))
             (width (if win (window-body-width win) (frame-width)))
             (height (if win (window-body-height win) (frame-height)))
             (center (lambda (s)
                       (concat (make-string (max 0 (/ (- width (length s)) 2)) ?\s)
                               s)))
             (lines (list (funcall center "Oceanic Emacs")
                          ""
                          (funcall center (format "Emacs %s" emacs-version))
                          (funcall center (if (daemonp) "daemon" "standalone"))
                          ""
                          (funcall center (format-time-string "%A, %d %B %Y"))
                          ""
                          (funcall center (format "Loaded in %.2fs" (om-dashboard--load-time)))))
             (top-pad (max 0 (/ (- height (length lines)) 2))))
        (erase-buffer)
        (insert (make-string top-pad ?\n))
        (dolist (line lines)
          (insert line "\n")))
      (special-mode)
      (local-set-key (kbd "g") #'om-dashboard-render)
      (goto-char (point-min)))))

(setq initial-buffer-choice
      (lambda ()
        (let ((buf (get-buffer-create om-dashboard-buffer)))
          (run-with-idle-timer 0 nil #'om-dashboard-render)
          buf)))

(provide 'dashboard)
;;; dashboard.el ends here
