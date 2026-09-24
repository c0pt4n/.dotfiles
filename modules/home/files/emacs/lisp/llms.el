;;; llms.el --- LLM agents -*- lexical-binding: t; -*-

(defun my/openrouter-api-key ()
  "Read OpenRouter API key from pass"
  (or (bound-and-true-p my/--openrouter-key)
      (setq my/--openrouter-key
            (string-trim
             (shell-command-to-string "pass LLMs/openrouter.ai")))))

(defun my/gemini-api-key ()
  "Read Gemini API key from pass."
  (or (bound-and-true-p my/--gemini-key)
      (setq my/--gemini-key
            (string-trim
             (shell-command-to-string "pass LLMs/geminikey")))))

(use-package gptel
  :config
  (setq gptel-default-mode 'org-mode)

  (setq gptel-backend
        (gptel-make-openai "OpenRouter"
          :host "openrouter.ai"
          :endpoint "/api/v1/chat/completions"
          :stream t
          :key #'my/openrouter-api-key
          :models '(qwen/qwen3.8-27b:free
                    meta-llama/llama-3.3-70b-instruct:free
                    mistralai/mistral-small-3.1-24b-instruct:free
                    google/gemma-3-27b-it:free)))

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
