;;; ghostel-config.el --- Ghostel term setup -*- lexical-binding: t; -*-

(use-package ghostel
  :hook
  ((ghostel-mode . (lambda()
                     (setq-local mode-line-format nil)))))

(provide 'ghostel-config)
;;; ghostel-config.el ends here
