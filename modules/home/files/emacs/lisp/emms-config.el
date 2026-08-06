;;; emms-config.el --- Description -*- lexical-binding: t; -*-

(use-package emms
  :hook
  (emms-browser-mode  . meow-insert-mode)
  (emms-playlist-mode . meow-insert-mode)
  :bind (:map emms-browser-mode-map
			  ("_"   . emms-volume-lower)
			  ("RET" . emms-browser-add-tracks-and-play)
			  :map emms-playlist-mode-map
			  ("_"   . emms-volume-lower))
  :commands (emms
			 emms-browser
			 emms-playlist-mode-go
			 emms-pause
			 emms-stop
			 emms-next
			 emms-previous
			 emms-shuffle)
  :init
  (setq emms-source-file-default-directory "~/music"
		emms-playlist-buffer-name "*Music*"
		emms-info-asynchronously t)
  :config
  (emms-all)
  (emms-default-players)
  (emms-mode-line-mode 1)
  (emms-playing-time-mode 1)

  (setq emms-browser-default-browse-type 'info-title
        emms-browser-covers #'emms-browser-cache-thumbnail-async
        emms-browser-thumbnail-small-size 64
        emms-browser-thumbnail-medium-size 128
        emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)

  ;; MPD
  (setq emms-player-mpd-music-directory "~/music"
        emms-volume-change-function #'emms-volume-mpd-change
        emms-player-list '(emms-player-mpd
						   emms-player-mplayer
						   emms-player-vlc
						   emms-player-mpg321
						   emms-player-ogg123))

  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (add-to-list 'emms-info-functions 'emms-info-ogginfo)
  (add-to-list 'emms-info-functions 'emms-info-tinytag)

  (run-with-timer 0.1 nil #'emms-player-mpd-connect))

(defun oceanic/update-emms-from-mpd ()
  "Update EMMS cache from MPD and refresh browser"
  (interactive)
  (require 'emms)
  (message "Updating EMMS cache from MPD")
  (emms-player-mpd-connect)
  (emms-cache-set-from-mpd-all)
  (message "EMMS cache updated. Refreshing browser...")
  (when (get-buffer "*EMMS Browser*")
	(with-current-buffer "*EMMS Browser*"
	  (emms-browser-refresh))))

(provide 'emms-config)
;;; emms-config.el ends here
