;;; flash-config.el --- Description -*- lexical-binding: t; -*-

(use-package flash
  :custom
  (flash-autojump t)
  (flash-search-folds t)
  :config
  (require 'flash-isearch)
  (flash-isearch-mode 1))

(provide 'flash-config)
;;; flash-config.el ends here
