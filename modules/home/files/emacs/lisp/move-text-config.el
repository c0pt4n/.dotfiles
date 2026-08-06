;;; move-text-config.el --- Description -*- lexical-binding: t; -*-

(use-package move-text
  :bind (("M-<down>"  . move-text-down)
		 ("M-<up>"    . move-text-up)
		 ("M-<right>" . forward-word)
		 ("M-<left>"  . backward-word)))

(provide 'move-text-config)
;;; move-text-config.el ends here
