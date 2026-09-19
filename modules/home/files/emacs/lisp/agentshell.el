;;; agentshell.el --- Agentic workflow -*- lexical-binding: t; -*-

(use-package agent-shell
  :config
  (setopt agent-shell-dot-subdir-function
          (lambda (subdir) (expand-file-name subdir no-littering-var-directory))))

(provide 'agentshell)
;;; agentshell.el ends here
