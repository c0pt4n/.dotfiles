;;; llms.el --- LLM agents -*- lexical-binding: t; -*-

(defun my/gemini-api-key ()
  "Read Gemini API key from pass."
  (or (bound-and-true-p my/--gemini-key)
      (setq my/--gemini-key
            (string-trim
             (shell-command-to-string "pass LLMs/geminikey")))))

(use-package gptel
  :config
  (setq gptel-default-mode 'org-mode)
  ;; gemini backend
  (setq gptel-backend
        (gptel-make-gemini "Gemini"
                           :key #'my/gemini-api-key
                           :stream t
                           :models '(gemini-3-flash-preview
                                     gemini-2.5-flash
                                     gemini-2.5-pro
                                     gemini-flash-latest)))
  (setq gptel-model 'gemini-3-flash-preview))

(provide 'llms)
;;; llms.el ends here
