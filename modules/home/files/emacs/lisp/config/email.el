;;; -*- lexical-binding: t; -*-

(use-package mu4e
  :ensure nil
  :demand t
  :commands (mu4e mu4e-compose-new)
  :init
  (setq mu4e-mu-binary (executable-find "mu"))
  :config
  (setq mu4e-maildir "~/.local/share/mail"
        mu4e-get-mail-command "mailsync"
        mu4e-update-interval 300
        mu4e-change-filenames-when-moving t
        mu4e-attachment-dir "~/dls"
        mu4e-compose-format-flowed t
        mu4e-view-show-images t
        mu4e-view-show-addresses t)

  (setq message-send-mail-function 'message-send-mail-with-sendmail
        send-mail-function          'sendmail-send-it
        sendmail-program            (executable-find "msmtp")
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-sendmail-f-is-evil  t
        mail-specify-envelope-from  t
        mail-envelope-from          'header)

  (mu4e-context "main"
    :enter-func (lambda () (oceanic/mu4e-set-msmtp "main"))
    :match-func (lambda (msg)
                  (when msg
                    (mu4e-message-contact-field-matches msg :to "omarcoptan9@gmail.com")))
    :vars '((user-mail-address . "omarcoptan9@gmail.com")
            (user-full-name . "Omar Mohamed")
            (mu4e-drafts-folder . "/omarcoptan9@gmail.com/[Gmail]/Drafts")
            (mu4e-sent-folder . "/omarcoptan9@gmail.com/[Gmail]/Sent Mail")
            (mu4e-trash-folder . "/omarcoptan9@gmail.com/[Gmail]/Trash")
            (mu4e-refile-folder . "/omarcoptan9@gmail.com/[Gmail]/All Mail")
            (mu4e-maildir-shortcuts
             . ((:maildir "/omarcoptan9@gmail.com/INBOX" :key ?i)
                (:maildir "/omarcoptan9@gmail.com/[Gmail]/All Mail" :key ?a)))))

  (mu4e-context "alt"
    :enter-func (lambda () (oceanic/mu4e-set-msmtp "alt"))
    :match-func (lambda (msg)
                  (when msg
                    (mu4e-message-contact-field-matches msg :to "theomarmohamedofficial@gmail.com")))
    :vars '((user-mail-address . "theomarmohamedofficial@gmail.com")
            (user-full-name . "Omar Mohamed")
            (mu4e-drafts-folder . "/theomarmohamedofficial@gmail.com/[Gmail]/Drafts")
            (mu4e-sent-folder . "/theomarmohamedofficial@gmail.com/[Gmail]/Sent Mail")
            (mu4e-trash-folder . "/theomarmohamedofficial@gmail.com/[Gmail]/Trash")
            (mu4e-refile-folder . "/theomarmohamedofficial@gmail.com/[Gmail]/All Mail")
            (mu4e-maildir-shortcuts
             . ((:maildir "/theomarmohamedofficial@gmail.com/INBOX" :key ?i)))))
  (mu4e t))

(provide 'config/email)
