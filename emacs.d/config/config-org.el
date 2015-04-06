(require 'org)
(require 'evil-org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(evil-leader/set-key "a" 'org-agenda)

(setq org-log-done t)

(setq org-directory "~/Dropbox/org")
(setq org-mobile-inbox-for-pull "~/Dropbox/org/inbox.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-mobile-files '("~/Dropbox/org"))
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files (list org-directory))

(define-key global-map "\C-cc" 'org-capture)

(setq org-clock-persist 'history)

(provide 'config-org)
