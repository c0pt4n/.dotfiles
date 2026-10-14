;;; -*- lexical-binding: t; -*-

(use-package evil
  :demand t
  :init
  (setopt evil-want-integration t
          evil-want-keybinding nil
          evil-want-C-u-scroll t
          evil-want-C-i-jump t
          evil-insert-state-cursor 'box
          evil-search-module 'isearch
          evil-kill-on-visual-paste nil
          evil-visual-update-x-selection-p nil)
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (with-eval-after-load 'undo-tree
    (setopt evil-undo-system 'undo-tree))
  :bind
  (:map evil-insert-state-map
        ("C-g" . #'evil-normal-state)))

(use-package evil-collection
  :demand t
  :after (evil)
  :init
  (setopt evil-collection-want-unimpaired-p t)
  :config
  (evil-collection-init))

(use-package general
  :demand t
  :config
  (general-evil-setup t)

  (general-create-definer leader
    :states '(normal visual)
    :prefix "SPC")

  (leader
    "SPC"   '(execute-extended-command :which-key "M-x")
    "y"     (kbd "\"+y")
    "Y"     (kbd "\"+y$")
    "d"     (kbd "\"_d")
    "D"     (kbd "\"_D")
    "s"     '(my/substitute-word-under-cursor :which-key "Substitute Word")
    "j"     '((lambda () (interactive) (previous-error) (evil-scroll-line-to-center nil)) :which-key "Prev Error")
    "k"     '((lambda () (interactive) (next-error) (evil-scroll-line-to-center nil)) :which-key "Next Error")
    "."     '(find-file :which-key "Find File")
    ","     '(consult-buffer :which-key "Buffers")
    "/"     '(consult-line :which-key "Search")
    "c c"   '(compile)
    "f s"   '(save-buffer :which-key "Save")
    "f f"   '(project-find-file :which-key "Find File (Project)")
    "f r"   '(consult-recent-file :which-key "Recent")
    "f d"   '(consult-fd :which-key "fd")
    "f g"   '(consult-ripgrep :which-key "Ripgrep")
    "f t"   '((lambda () (interactive) (find-file (expand-file-name "inbox.org" org-directory))) :which-key "Todo")
    "b b"   '(switch-to-buffer :which-key "Buffers")
    "b d"   '(flymake-show-buffer-diagnostics :which-key "Show Diagnostics (flymake)")
    "a k"   '(flymake-goto-next-error :which-key "Next Error (flymake)")
    "a j"   '(flymake-goto-prev-error :which-key "Previous Error (flymake)")
    "w"     '(:ignore t :which-key "Window")
    "w v"   '(split-window-right :which-key "Vertical")
    "w s"   '(split-window-below :which-key "Horizontal")
    "w l"   '(windmove-right :which-key "Right")
    "w h"   '(windmove-left :which-key "Left")
    "w k"   '(windmove-up :which-key "Up")
    "w j"   '(windmove-down :which-key "Down")
    "w c"   '(delete-window :which-key "Delete")
    "w o"   '(delete-other-windows :which-key "Delete other windows")
    "w u"   '(winner-undo :which-key "Winner undo")
    "w r"   '(winner-redo :which-key "Winner redo")
    "p p"   '(project-switch-project :which-key "Project")
    "p f"   '(project-find-file :which-key "Project File")
    "p s"   '(persp-switch :which-key "Switch Project")
    "p r"   '(project-find-regexp :which-key "Project Regexp")
    "p R"   '(project-query-replace-regexp :which-key "Project Replace Regexp")
    "g s"   '(magit-status :which-key "Git")
    "g c"   '(magit-clone :which-key "Clone a repo")
    "b m"   '(bookmark-set :which-key "Bookmark")
    "b D"   '(bookmark-delete :which-key "Delete Bookmark")
    "b k"   '(kill-current-buffer :which-key "Kill Buffer")
    "b K"   '(my/kill-other-buffers :which-key "Kill Other Buffers")
    "b x"   '(kill-buffer-and-window :which-key "Kill buffer and window")
    "b l"   '((lambda () (interactive) (switch-to-buffer nil)) :which-key "Last Buffer")
    "b b"   '(switch-to-buffer :which-key "Buffers")
    "b n"   '(next-buffer :which-key "Next Buffer")
    "b p"   '(previous-buffer :which-key "Previous Buffer")
    "b i"   '(ibuffer :which-key "Ibuffer")
    "b r"   '(revert-buffer :which-key "Revert Buffer")
    "b f"   '(apheleia-format-buffer :which-key "Format Buffer")
    "b F"   '(eglot-format-buffer :which-key "Format Buffer (eglot)")
    "h"     '(:ignore t :which-key "Help")
    "h b"   '(describe-bindings :wk "Describe bindings")
    "h v"   '(describe-variable :wk "Describe variable")
    "r c"   '((lambda () (interactive) (load-file user-init-file) (message "config reloaded")) :which-key "Reload Config")
    "m"     '(:ignore t :which-key "EMMS")
    "m u"   '(oceanic/update-emms-from-mpd :which-key "Update EMMS")
    "m d"   '(emms-add-directory-tree :which-key "EMMS add directory")
    "m o"   '(emms-browser :which-key "EMMS Browser")
    "m p"   '(emms-playlist-mode-go :which-key "EMMS Playlist")
    "m s"   '(emms-player-mpd-clear :which-key "Clear MPD Playlist")
    "m x"   '(emms-pause :which-key "Pause EMMS")
    "m b"   '(emms-previous :which-key "Previous Track")
    "m n"   '(emms-next :which-key "Next Track")
    "o"     '(:ignore t :which-key "Open")
    "o t"   '(term-scratch :which-key "Scratch Terminal")
    "o T"   '(ghostel :which-key "Terminal")
    "o d"   '(dirvish :which-key "Dirvish")
    "o p"   '(pass :which-key "Pass")
    "K"     '(consult-yank-from-kill-ring :which-key "Yank")
    "C"     '(org-capture :which-key "Org Capture")
    "n r i" '(org-roam-capture :which-key "Org Roam Capture")
    "n r f" '(org-roam-node-find :which-key "Org Roam Find")
    "n j"   '(org-roam-dailies-capture-today :which-key "Org Roam Daily"))

  (general-define-key
    :states 'visual
    "p" (kbd "\"_dP")
    "J" '(move-text-down :which-key "Move Down")
    "K" '(move-text-up :which-key "Move Up"))

  (defun my/kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (dolist (buf (delq (current-buffer) (buffer-list)))
      (unless (string-match-p "\\`[ *]" (buffer-name buf))
        (kill-buffer buf))))

  (defun my/substitute-word-under-cursor ()
    "Populate an ex substitute command for the symbol at point,
    cursor left ready to edit the replacement."
    (interactive)
    (let ((word (or (thing-at-point 'symbol t) "")))
      (minibuffer-with-setup-hook
        (lambda () (goto-char (- (point-max) 3)))
        (evil-ex (format "%%s/\\<%s\\>/%s/gI" word word))))))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode 1))

(use-package evil-lion
  :after evil
  :config
  (evil-lion-mode))

(use-package move-text)

(use-package flash
  :custom
  (flash-autojump t)
  (flash-search-folds t)
  :init
  (with-eval-after-load 'evil
    (require 'flash-evil)
    (flash-evil-setup t))
  :config
  (require 'flash-isearch)
  (flash-isearch-mode 1))

(global-set-key (kbd "C-x k") #'kill-current-buffer)

;; Zoom
(global-set-key (kbd "C-=") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)

(provide 'config/modal)
