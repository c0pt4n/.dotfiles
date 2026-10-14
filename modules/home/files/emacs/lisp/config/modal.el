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
  :after evil
  :init
  (setopt evil-collection-want-unimpaired-p t)
  :config
  (evil-collection-init))

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

(use-package evil-org
  :after (evil org)
  :hook (org-mode . evil-org-mode))

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

(use-package general
  :demand t
  :config
  (general-evil-setup t)

  (general-create-definer leader
    :states '(normal visual)
    :prefix "SPC")

  (leader
    "SPC"   '(execute-extended-command :wk "M-x")
    "y"     (kbd "\"+y")
    "Y"     (kbd "\"+y$")
    "d"     (kbd "\"_d")
    "D"     (kbd "\"_D")
    "s"     '(my/substitute-word-under-cursor :wk "Substitute Word")
    "j"     '((lambda () (interactive) (previous-error) (evil-scroll-line-to-center nil)) :wk "Prev Error")
    "k"     '((lambda () (interactive) (next-error) (evil-scroll-line-to-center nil)) :wk "Next Error")
    "."     '(find-file :wk "Find File")
    ","     '(consult-buffer :wk "Buffers")
    "/"     '(consult-line :wk "Search")
    "c c"   '(compile)
    "f s"   '(save-buffer :wk "Save")
    "f f"   '(project-find-file :wk "Find File (Project)")
    "f r"   '(consult-recent-file :wk "Recent")
    "f d"   '(consult-fd :wk "fd")
    "f g"   '(consult-ripgrep :wk "Ripgrep")
    "f t"   '((lambda () (interactive) (find-file (expand-file-name "inbox.org" org-directory))) :wk "Todo")
    "b d"   '(flymake-show-buffer-diagnostics :wk "Show Diagnostics (flymake)")
    "a k"   '(flymake-goto-next-error :wk "Next Error (flymake)")
    "a j"   '(flymake-goto-prev-error :wk "Previous Error (flymake)")
    "w"     '(:ignore t :wk "Window")
    "w v"   '(split-window-right :wk "Vertical")
    "w s"   '(split-window-below :wk "Horizontal")
    "w l"   '(windmove-right :wk "Right")
    "w h"   '(windmove-left :wk "Left")
    "w k"   '(windmove-up :wk "Up")
    "w j"   '(windmove-down :wk "Down")
    "w c"   '(delete-window :wk "Delete")
    "w o"   '(delete-other-windows :wk "Delete other windows")
    "w u"   '(winner-undo :wk "Winner undo")
    "w r"   '(winner-redo :wk "Winner redo")
    "p p"   '(project-switch-project :wk "Project")
    "p f"   '(project-find-file :wk "Project File")
    "p s"   '(persp-switch :wk "Switch Project")
    "p r"   '(project-find-regexp :wk "Project Regexp")
    "p R"   '(project-query-replace-regexp :wk "Project Replace Regexp")
    "g s"   '(magit-status :wk "Git")
    "g c"   '(magit-clone :wk "Clone a repo")
    "b m"   '(bookmark-set :wk "Bookmark")
    "b D"   '(bookmark-delete :wk "Delete Bookmark")
    "b k"   '(kill-current-buffer :wk "Kill Buffer")
    "b K"   '(my/kill-other-buffers :wk "Kill Other Buffers")
    "b x"   '(kill-buffer-and-window :wk "Kill buffer and window")
    "b l"   '((lambda () (interactive) (switch-to-buffer nil)) :wk "Last Buffer")
    "b b"   '(switch-to-buffer :wk "Buffers")
    "b n"   '(next-buffer :wk "Next Buffer")
    "b p"   '(previous-buffer :wk "Previous Buffer")
    "b i"   '(ibuffer :wk "Ibuffer")
    "b r"   '(revert-buffer :wk "Revert Buffer")
    "b f"   '(apheleia-format-buffer :wk "Format Buffer")
    "b F"   '(eglot-format-buffer :wk "Format Buffer (eglot)")
    "h"     '(:ignore t :wk "Help")
    "h b"   '(describe-bindings :wk "Describe bindings")
    "h v"   '(describe-variable :wk "Describe variable")
    "r c"   '((lambda () (interactive) (load-file user-init-file) (message "config reloaded")) :wk "Reload Config")
    "m"     '(:ignore t :wk "EMMS")
    "m u"   '(oceanic/update-emms-from-mpd :wk "Update EMMS")
    "m d"   '(emms-add-directory-tree :wk "EMMS add directory")
    "m o"   '(emms-browser :wk "EMMS Browser")
    "m p"   '(emms-playlist-mode-go :wk "EMMS Playlist")
    "m s"   '(emms-player-mpd-clear :wk "Clear MPD Playlist")
    "m x"   '(emms-pause :wk "Pause EMMS")
    "m b"   '(emms-previous :wk "Previous Track")
    "m n"   '(emms-next :wk "Next Track")
    "o"     '(:ignore t :wk "Open")
    "o t"   '(term-scratch :wk "Scratch Terminal")
    "o T"   '(ghostel :wk "Terminal")
    "o d"   '(dirvish :wk "Dirvish")
    "o p"   '(pass :wk "Pass")
    "K"     '(consult-yank-from-kill-ring :wk "Yank")
    "C"     '(org-capture :wk "Org Capture")
    "n r i" '(org-roam-capture :wk "Org Roam Capture")
    "n r f" '(org-roam-node-find :wk "Org Roam Find")
    "n j"   '(org-roam-dailies-capture-today :wk "Org Roam Daily"))

  (general-define-key
    :states 'visual
    "p" (kbd "\"_dP")
    "J" '(move-text-down :wk "Move Down")
    "K" '(move-text-up :wk "Move Up"))

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

(global-set-key (kbd "C-x k") #'kill-current-buffer)

;; Zoom
(global-set-key (kbd "C-=") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)

(provide 'config/modal)
