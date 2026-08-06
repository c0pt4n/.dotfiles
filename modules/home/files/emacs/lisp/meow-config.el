;;; meow-config.el --- Description -*- lexical-binding: t; -*-

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-leader-define-key
   '("?" . meow-cheatsheet)

   '("." . find-file)
   '("/" . consult-ripgrep)

   ;; Projects
   '("SPC" . project-find-file)
   '("p R" . project-query-replace-regexp)

   ;; Bookmars
   '("b m" . bookmark-set)
   '("b D" . bookmark-delete)

   ;; Buffers
   '("," . consult-buffer)
   '("b k" . kill-current-buffer)
   '("b l" . (lambda () (interactive) (switch-to-buffer nil)))
   '("b b" . switch-to-buffer)
   '("b n" . next-buffer)
   '("b p" . previous-buffer)
   '("b i" . ibuffer)
   '("b r" . revert-buffer)

   '("c c" . compile)

   '("e g" . gptel)
   '("e s" . gptel-send)

   ;; Files
   '("f r" . consult-recent-file)
   '("f c" . (lambda () (interactive) (find-file (expand-file-name "init.el" user-emacs-directory))))
   '("f e" . (lambda () (interactive) (dirvish user-emacs-directory)))
   '("f t" . (lambda () (interactive) (find-file (expand-file-name "inbox.org" org-directory))))

   ;; Magit
   '("g" . magit-status)

   ;; Emms
   '("m u" . oceanic/update-emms-from-mpd)
   '("m d" . emms-add-directory-tree)
   '("m o" . emms-browser)
   '("m p" . emms-playlist-mode-go)
   '("m s" . emms-stop)
   '("m x" . emms-pause)
   '("m b" . emms-previous)
   '("m n" . emms-next)

   ;; Toggling keybindings
   '("o t" . om/vterm)
   '("o T" . vterm)
   '("o d" . dirvish)

   ;; Password-store
   '("p p" . pass)

   ;; Org
   '("C" . org-capture)
   '("n r i" . org-roam-capture)
   '("n r f" . org-roam-node-find)
   '("n j" . org-roam-dailies-capture-today)

   ;; Window bindings
   '("w v" . split-window-right)
   '("w s" . split-window-below)
   '("w c" . delete-window)
   '("w o" . delete-other-windows)
   '("w l" . windmove-right)
   '("w k" . windmove-up)
   '("w j" . windmove-down)
   '("w h" . windmove-left)

   '("y y" . om/clipboard-manager)

   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument))

  (meow-motion-define-key
   '("^" . back-to-indentation)
   '("l" . meow-line)
   '("e" . meow-next-word)
   '(";" . meow-reverse)
   '("v" . meow-visit)
   '("n" . meow-search)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("y" . meow-clipboard-save)
   '("g" . meow-cancel-selection)
   '("f" . flash-jump)
   '("/" . consult-line)
   '("<escape>" . ignore))

  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("^" . back-to-indentation)
   '("a" . meow-append)
   '("o" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . flash-jump)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("O" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("%" . meow-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . undo-tree-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("/" . consult-line)
   '("<escape>" . ignore)))

(use-package meow
  :demand t
  :init
  (setq meow-keypad-meta-prefix ?M)
  (setq meow-keypad-ctrl-meta-prefix ?G)
  (setq meow-cursor-type-insert 'box)
  :config
  (add-to-list 'meow-mode-state-list '(vterm-mode . insert))
  (meow-setup)
  (meow-global-mode))

;; Window movement
(global-set-key (kbd "C-<left>")  #'windmove-left)
(global-set-key (kbd "C-<right>") #'windmove-right)
(global-set-key (kbd "C-<down>")  #'windmove-down)
(global-set-key (kbd "C-<up>")    #'windmove-up)

;; Zoom
(global-set-key (kbd "C-=") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)

;; Save
(global-set-key (kbd "C-r") #'undo-tree-redo)

(provide 'meow-config)
;;; meow-config.el ends here
