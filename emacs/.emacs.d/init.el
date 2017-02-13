;;; BalkEmacs --- My emacs configuration
;;; Commentary:

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

(quelpa 'use-package)
                                        ;'(use-package
                                        ;:fetcher github
                                        ;:repo "quelpa/quelpa-use-package"))
(require 'use-package)
(quelpa
 '(quelpa-use-package
   :fetcher github
   :repo "quelpa/quelpa-use-package"))
(require 'quelpa-use-package)

(use-package evil
  :ensure
  :init (progn
          (setq evil-want-C-u-scroll t)
          )
  :config (progn

            (evil-mode)
            (use-package evil-leader :ensure)
            (use-package evil-matchit :ensure)
            (use-package evil-magit :ensure)
            (use-package evil-nerd-commenter
              :ensure
              :config (progn
                        (evilnc-default-hotkeys)
                        )
              )
            (use-package evil-surround :ensure)
            (use-package ace-jump-mode :ensure
              :config (progn
                        (eval-after-load "ace-jump-mode"
                          '(ace-jump-mode-enable-mark-sync))
                        (define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
                        ))

            ;; Evil global modes config
            (evilnc-default-hotkeys)
            (setq evil-default-cursor t)

            ;; Evil global modes 
            (global-evil-jumper-mode 1)
            (global-evil-surround-mode 1)
            (global-evil-leader-mode)
            (global-evil-matchit-mode 1)

            ;; exclude modes from evil mode
            (add-to-list 'evil-emacs-state-modes 'git-rebase-mode)
            (add-to-list 'evil-emacs-state-modes 'undo-tree-visualizer-mode)
            (add-to-list 'evil-emacs-state-modes 'dired-mode)

            (defun next-code-buffer ()
                  ;;; Avoid special buffers when cycling through windows
                  ;;; http://stackoverflow.com/questions/14323516/make-emacs-next-buffer-skip-messages-buffer
              (interactive)
              (let (( bread-crumb (buffer-name) ))
                (next-buffer)
                (while
                    (and
                     (string-match-p "^\*" (buffer-name))
                     (not ( equal bread-crumb (buffer-name) )) )
                  (next-buffer))))

            (defun previous-code-buffer ()
              (interactive)
              (let (( bread-crumb (buffer-name) ))
                (previous-buffer)
                (while
                    (and
                     (string-match-p "^\*" (buffer-name))
                     (not ( equal bread-crumb (buffer-name) )) )
                  (previous-buffer))))

            ;; change mode-line color by evil state
            (lexical-let ((default-color (cons (face-background 'mode-line)
                                               (face-foreground 'mode-line))))
              (add-hook 'post-command-hook
                        (lambda ()
                          (let ((color (cond ((minibufferp) default-color)
                                             ((evil-insert-state-p) (cons (cdr default-color) (car default-color)))
                                             ((evil-emacs-state-p) default-color)
                                             ((buffer-modified-p)   '("#ff0000" . "#ffffff"))
                                             (t default-color))))
                            (set-face-background 'mode-line (car color))
                            (set-face-foreground 'mode-line (cdr color))))))
            ;; Evil keys 
            (evil-leader/set-leader "<SPC>")

            (define-key evil-normal-state-map (kbd "[q") 'previous-error)
            (define-key evil-normal-state-map (kbd "]q") 'next-error)
            (define-key evil-normal-state-map (kbd "[b") 'previous-code-buffer)
            (define-key evil-normal-state-map (kbd "]b") 'next-code-buffer)
            (define-key evil-normal-state-map (kbd "s") 'evil-ace-jump-char-mode)
            (define-key evil-normal-state-map (kbd "S") 'evil-ace-jump-word-mode)
            (define-key evil-normal-state-map (kbd ",d") 'neotree-toggle)
            (define-key evil-normal-state-map (kbd ",u") 'undo-tree-visualize)

            (define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
            (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

            (add-hook 'neotree-mode-hook
                      (lambda ()
                        (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
                        (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
                        (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
                        (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

            )

  )

(use-package guide-key
  :ensure
  :config (progn
            (setq guide-key/guide-key-sequence t)
            (guide-key-mode 1)
            ))

(use-package projectile
  :ensure
  :config (progn
            (projectile-global-mode)
            (setq projectile-switch-project-action 'projectile-dired)
            ))

(use-package helm
  :ensure t
  :config (progn
            (use-package helm-config)
            (use-package helm-grep)
            (use-package helm-locate)
            (use-package helm-misc)
            (use-package helm-descbinds
              :config (progn
                        (helm-descbinds-mode)
                        )
              )
            (use-package helm-projectile :ensure
              :config (progn
                        (setq projectile-completion-system 'helm)
                        (helm-projectile-on)
                        ))
            (use-package helm-ag :ensure)

            (setq helm-quick-update t)
            (setq helm-bookmark-show-location t)
            (setq helm-buffers-fuzzy-matching t)
            (defun smart-for-files ()
              "Call `helm-projectile' if `projectile-project-p', otherwise fallback to `helm-for-files'."
              (interactive)
              (if (projectile-project-p)
                  (helm-projectile)
                (helm-for-files)))

        ;;; Save current position to mark ring
            (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

            ;; Better helm fonts
            (set-face-attribute 'helm-selection nil :background "gold" :foreground "black")

        ;;; Keyboard mappings 
            (global-set-key (kbd "M-y") 'helm-show-kill-ring)
            (global-set-key (kbd "C-x b") 'helm-mini)
            (global-set-key (kbd "C-x p") 'smart-for-files)
            (global-set-key (kbd "C-x C-f") 'helm-find-files)
            (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
            (global-set-key (kbd "C-c h o") 'helm-occur)

            (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
            (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
            (define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z
            (define-key helm-grep-mode-map (kbd "<return>") 'helm-grep-mode-jump-other-window)
            (define-key helm-grep-mode-map (kbd "n") 'helm-grep-mode-jump-other-window-forward)
            (define-key helm-grep-mode-map (kbd "p") 'helm-grep-mode-jump-other-window-backward)

            (define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
            (define-key evil-insert-state-map "\C-e" 'end-of-line)
            (define-key evil-visual-state-map "\C-e" 'evil-end-of-line)
            (define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
            (define-key evil-normal-state-map "\C-n" 'evil-next-line)
            (define-key evil-insert-state-map "\C-n" 'evil-next-line)
            (define-key evil-visual-state-map "\C-n" 'evil-next-line)
            (define-key evil-normal-state-map "\C-p" 'evil-previous-line)
            (define-key evil-insert-state-map "\C-p" 'evil-previous-line)
            (define-key evil-visual-state-map "\C-p" 'evil-previous-line)
            (define-key evil-normal-state-map "\C-k" 'kill-line)
            (define-key evil-insert-state-map "\C-k" 'kill-line)
            (define-key evil-visual-state-map "\C-k" 'kill-line)
            (define-key evil-normal-state-map "Q" 'call-last-kbd-macro)
            (define-key evil-visual-state-map "Q" 'call-last-kbd-macro)
        ;;; Evil helm
            ;; (define-key evil-normal-state-map (kbd "C-p") 'helm-mini)
            (evil-leader/set-key "p" 'smart-for-files)
            (evil-leader/set-key "<SPC>" 'helm-M-x)
            (define-key evil-normal-state-map (kbd ",s") 'helm-swoop)
            (define-key evil-normal-state-map (kbd ",a") 'helm-ag)
            (define-key evil-normal-state-map (kbd ",y") 'helm-show-kill-ring)

        ;;; Keyboard
            (global-set-key (kbd "M-x") 'helm-M-x)
            (define-key helm-map (kbd "C-w") 'backward-kill-word)

            ;; use helm to list eshell history
            (add-hook 'eshell-mode-hook
                      #'(lambda ()
                          (define-key eshell-mode-map (kbd "M-l") 'helm-eshell-history)))

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; PACKAGE: helm-swoop ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; Locate the helm-swoop folder to your path
            (use-package helm-swoop
              :ensure
              :config (progn
                        ;; Change the keybinds to whatever you like :)
                        (global-set-key (kbd "C-c h o") 'helm-swoop)
                        (global-set-key (kbd "C-c s") 'helm-multi-swoop-all)
                        ;; When doing isearch, hand the word over to helm-swoop
                        (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
                        ;; From helm-swoop to helm-multi-swoop-all
                        (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
                        ;; Save buffer when helm-multi-swoop-edit complete
                        (setq helm-multi-swoop-edit-save t)
                        ;; If this value is t, split window inside the current window
                        (setq helm-swoop-split-with-multiple-windows t)
                        ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
                        (setq helm-swoop-split-direction 'split-window-vertically)
                        ;; If nil, you can slightly boost invoke speed in exchange for text color
                        (setq helm-swoop-speed-or-color t)
                        ))
            (helm-mode 1)
            )
  )

(use-package auto-complete
  :ensure t
  :config (progn
            (ac-config-default)
            )

  )

(use-package flycheck
  :ensure t
  :config (progn
            (add-hook 'after-init-hook #'global-flycheck-mode)
            )
  )

(use-package popwin
  :ensure
  :config (progn
            (popwin-mode)
            ))


(use-package linum
  :config (progn
            (add-hook 'prog-mode-hook 'linum-mode)
            )
  )

(use-package monokai-theme
  :ensure t
  :config (progn
            (load-theme 'monokai)
            )
  )

(use-package slime
  :config (progn
            (setq inferior-lisp "/usr/bin/sbcl")
            (setq inferior-lisp-program (executable-find "sbcl"))
            (setq slime-contribs '(slime-fancy))
            )
  )

(use-package python
  :config (progn

            (use-package ob-ipython
              :config (progn
                        )
              )
            (setq
         ;;     python-shell-interpreter "compose-run"
	     ;; python-shell-interpreter-args "python ")
             python-shell-interpreter "ipython"
             python-shell-interpreter-args "--pylab"
             python-shell-prompt-regexp "In \\[[0-9]+\\]: "
             python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
             python-shell-completion-setup-code
             "from IPython.core.completerlib import module_completion"
             python-shell-completion-module-string-code
             "';'.join(module_completion('''%s'''))\n"
             python-shell-completion-string-code
             "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

            (add-hook 'python-mode-hook 'auto-complete-mode)
            (add-hook 'python-mode-hook '(lambda () (require 'nose)))

            (eval-after-load "python"
              '(progn
                 (define-key python-mode-map (kbd "C-c C-d") 'helm-pydoc)))

            (use-package jedi
              :config (progn
                        (setq jedi:complete-on-dot t)
                        (setq jedi:get-in-function-call-delay 500)
                        (add-hook 'python-mode-hook 'jedi:setup)
                        )

              )
            )
  )

(use-package go-mode
  :init (progn
          (use-package go-autocomplete :ensure
            :config (progn
                      (use-package auto-complete-config)
                      (ac-config-default)
                      )
            )
          (defun my-go-mode-hook ()
                                        ; Use goimports instead of go-fmt
            (setq gofmt-command "goimports")
                                        ; Call Gofmt before saving
            (add-hook 'before-save-hook 'gofmt-before-save)
                                        ; Customize compile command to run go build
            (if (not (string-match "go" compile-command))
                (set (make-local-variable 'compile-command)
                     "go build -v && go test -v && go vet"))
                                        ; Godef jump key binding
            (local-set-key (kbd "M-.") 'godef-jump))
          (add-hook 'go-mode-hook 'my-go-mode-hook)
          )
  )

(use-package flymake-go
  :ensure
  :init (progn
          )
  )

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

(use-package ensime
  :pin melpa-stable
  :config (progn
            (setq ensime-startup-snapshot-notification nil)
            (use-package flycheck-cask
              :ensure t
              :commands flycheck-cask-setup
              :config (add-hook 'emacs-lisp-mode-hook (flycheck-cask-setup)))
            ))

(use-package org
  :ensure t
  :config (progn
            (use-package evil-org :ensure t)
            (define-key global-map "\C-cl" 'org-store-link)
            (define-key global-map "\C-ca" 'org-agenda)
            (evil-leader/set-key "a" 'org-agenda)
            (evil-org-mode)


            (add-hook 'org-capture-mode-hook 'evil-insert-state)



            (setq org-log-done t)

            (setq org-directory "~/Dropbox/org")
            (setq org-mobile-inbox-for-pull "~/Dropbox/org/inbox.org")
            (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
            (setq org-mobile-files '("~/Dropbox/org"))
            (setq org-default-notes-file (concat org-directory "/notes.org"))
            (setq org-agenda-files (list org-directory))

            (define-key global-map "\C-cc" 'org-capture)

            (setq org-clock-persist 'history)

            ;; Set syntax highlight in org-mode babel
            (setq org-src-fontify-natively t)

            ;;;don't prompt me to confirm everytime I want to evaluate a block
            (setq org-confirm-babel-evaluate nil) 

            ;;; display/update images in the buffer after I evaluate
            (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

            ;; 
            (setq org-tag-alist '(
                                  (:startgroup . nil)
                                  ("@phd" . ?p) ("@home" . ?h)
                                  (:endgroup . nil)
                                  (:startgroup . nil)
                                  ("reading" . ?r) ("coding" . ?c) ("writing" . "w")
                                  (:endgroup . nil)
                                  )
                  )

            (defun org-archive-done-tasks ()
              (interactive)
              (org-map-entries
               (lambda ()
                 (org-archive-subtree)
                 (setq org-map-continue-from (outline-previous-heading)))
               "/DONE" 'file))
            (define-key org-mode-map "\C-cd" 'org-archive-done-tasks)

            (setq org-capture-templates
                  (quote
                   (("i" "Ideas" entry
                     (file "ideas.org")
                     "* %?" nil nil)
                    ("t" "Tasks" entry
                     (file "tasks.org")
                     "* TODO %?\n\t%i"))))

            (defadvice org-capture-finalize 
                (after delete-capture-frame activate)  
              "Advise capture-finalize to close the frame"  
              (if (equal "capture" (frame-parameter nil 'name))  
                  (delete-frame)))  
            
            (defadvice org-capture-destroy 
                (after delete-capture-frame activate)  
              "Advise capture-destroy to close the frame"  
              (if (equal "capture" (frame-parameter nil 'name))  
                  (delete-frame)))  
            
            ;; make the frame contain a single window. by default org-capture  
            ;; splits the window.  
            (add-hook 'org-capture-mode-hook  
                      'delete-other-windows)  
            
            (defun make-capture-frame ()  
              "Create a new frame and run org-capture."  
              (interactive)  
              (make-frame '((name . "capture") 
                            (width . 120) 
                            (height . 15)))  
              (select-frame-by-name "capture") 
              (setq word-wrap 1)
              (setq truncate-lines nil)
              (org-capture)
              (delete-other-windows)
              )
            )
  )

(use-package magit
  :ensure
  :config (progn
            (add-hook 'after-save-hook 'magit-after-save-refresh-status)
            )
  )


(use-package yaml-mode
  :config (progn
        (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
        (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
            )
  )

(use-package gist
  :config (progn
            )
  )

(use-package n3-mode
  :mode ("\\.ttl" "\\.n3")
  )

(use-package yasnippet
  :diminish yas-minor-mode
  :config (progn
            (yas-global-mode 1)
            )
  )

(use-package smartparens
  :diminish smartparens-mode
  :init
  :config (progn
            (use-package evil-paredit
              :ensure
              :config (progn
                        (use-package evil-smartparens :ensure)
                        (add-hook 'clojure-mode-hook 'smartparens-mode)
                        (add-hook 'cider-repl-mode-hook 'evil-smartparens-mode)
                        (add-hook 'lisp-mode-hook 'evil-smartparens-mode)
                        (add-hook 'emacs-lisp-mode-hook 'evil-smartparens-mode)
                        (add-hook 'lisp-interaction-mode-hook 'evil-smartparens-mode)
                        (add-hook 'ielm-mode-hook 'evil-smartparens-mode)
                        )
              )
            )
  )

(use-package markdown-mode
  :init
  :config (progn
            (setq markdown-command "pandoc -f markdown -t html -s")
            )
  )

(use-package go-mode
  :init
  :config (progn
            )
  )

(use-package mu4e
  :init
  :config (progn
            (use-package smtpmail
              :ensure)

            (setq mu4e-contexts
                  `( ,(make-mu4e-context
                       :name "Private"
                       :enter-func (lambda () (mu4e-message "Switch to the GMAIL context"))
                       ;; leave-func not defined
                       :match-func (lambda (msg)
                                     (when msg 
                                       (mu4e-message-contact-field-matches msg 
                                                                           :to "jfsanchezrada@gmail.com")))
                       :vars '(
                               (smtpmail-starttls-credentials '("smtp.gmail.com" 587 nil nil))
                               (smtpmail-auth-credentials '(("smtp.gmail.com" 587 "jfsanchezrada@gmail.com" nil)))
                               (smtpmail-default-smtp-server "smtp.gmail.com")
                               (smtpmail-smtp-server "smtp.gmail.com")
                               (smtpmail-smtp-service 587)
                               (smtpmail-debug-info t)
                               ( user-mail-address	     . "jfsanchezrada@gmail.com"  )
                                 ( user-full-name	    . "J. Fernando Sánchez Rada" )
                                 ( mu4e-compose-signature . "J. Fernando Sánchez\n")))
                     ,(make-mu4e-context
                       :name "Sinpapel"
                       :enter-func (lambda () (mu4e-message "Switch to the Personal context"))
                       ;; leave-fun not defined
                       :match-func (lambda (msg)
                                     (when msg 
                                       (mu4e-message-contact-field-matches msg 
                                                                           :to "j@sinpapel.es")))
                       :vars '(
                               (smtpmail-starttls-credentials '(("smtp.sinpapel.es" 587 nil nil)))
                               (smtpmail-auth-credentials '(("smtp.sinpapel.es" 587 "j@sinpapel.es" nil)))
                               (smtpmail-default-smtp-server "smtp.sinpapel.es")
                               (smtpmail-smtp-server "smtp.sinpapel.es")
                               (smtpmail-smtp-service 587)
                               (smtpmail-debug-info t)
                               ( user-mail-address	     . "j@sinpapel.es"  )
                               ( user-full-name	    . "J. Fernando Sánchez Rada" )
                               ( mu4e-compose-signature . 
                                                        "J. Fernando Sánchez\n"))))
                  )


            (setq mu4e-compose-context-policy nil)

            (setq message-send-mail-function 'smtpmail-send-it
                  starttls-use-gnutls t
                  smtpmail-debug-info t)

            (setq mu4e-maildir (expand-file-name "~/.mail/"))
            (setq mu4e-drafts-folder "/Drafts")
            (setq mu4e-sent-folder   "/Sent Items")
            (setq mu4e-trash-folder  "/Trash")
            (setq message-signature-file "~/.emacs.d/.signature") ; put your signature in this file
            (setq mu4e-get-mail-command "mbsync gmail-inbox balkian"
                  mu4e-html2text-command "w3m -T text/html"
                  mu4e-update-interval 300
                  mu4e-headers-auto-update t
                  mu4e-compose-signature-auto-include nil)
            (add-to-list 'mu4e-view-actions
                         '("ViewInBrowser" . mu4e-action-view-in-browser) t)
            (setq mu4e-maildir-shortcuts
                  '( ("/gmail/INBOX"               . ?i)
                     ("/Sent Items"   . ?s)
                     ("/Trash"       . ?t)
                     ("/Drafts"    . ?d)))

            ;; use imagemagick if available
            (when (fboundp 'imagemagick-register-types)
              (imagemagick-register-types))

            ;; general emacs mail settings; used when composing e-mail
            ;; the non-mu4e-* stuff is inherited from emacs/message-mode
            (setq mu4e-reply-to-address "jfsanchezrada@gmail.com"
                  user-mail-address "jfsanchezrada@gmail.com"
                  user-full-name  "J. Fernando Sánchez")
            ;; show images
            (setq mu4e-show-images t
                  mu4e-show-addresses t)

            ;; By default, mu4e only shows contact names
            (setq mu4e-view-show-addresses t)
            ;; don't save message to Sent Messages, IMAP takes care of this
            (setq mu4e-sent-messages-behavior 'delete)

            (add-hook 'mu4e-compose-mode-hook
                      (defun my-do-compose-stuff ()
                        "My settings for message composition."
                        (set-fill-column 72)
                        (flyspell-mode)))
            )
  )

;;; Global emacs settings
;; disable splash screen
(setq inhibit-splash-screen t)
(setq initial-scratch-message "\
;; SCRATCHPAD
")
(setq truncate-partial-width-windows nil)
(set-default 'truncate-lines nil)
;;; Highlight line
(global-hl-line-mode)
                                        ;; (set-face-background 'hl-line 'highlight-color)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq default-tab-width 4); 
(setq js-indent-level 2)

(toggle-indicate-empty-lines)

;;; Global modes
(scroll-bar-mode 0)
(tool-bar-mode 0)
(savehist-mode 1)
(show-paren-mode t)
(column-number-mode)
(when (fboundp 'winner-mode)
  (winner-mode 1))


;;; Other key bindings
(define-key global-map "\C-ch" 'winner-undo)
(define-key global-map "\C-cl" 'winner-redo)
 

;; set a default font
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-12"))
;; emacs doesn't actually save undo history with revert-buffer
;; see http://lists.gnu.org/archive/html/bug-gnu-emacs/2011-04/msg00151.html
;; fix that.
(defun revert-buffer-keep-history (&optional IGNORE-AUTO NOCONFIRM PRESERVE-MODES)
  (interactive)

  (setq tmp (point))
  ;; tell Emacs the modtime is fine, so we can edit the buffer
  (clear-visited-file-modtime)

  ;; insert the current contents of the file on disk
  (widen)
  (delete-region (point-min) (point-max))
  (insert-file-contents (buffer-file-name))

  ;; mark the buffer as not modified
  (not-modified)
  (set-visited-file-modtime)
  (goto-char tmp)
  )

(setq revert-buffer-function 'revert-buffer-keep-history)

(use-package recentf
  :config (progn
            (recentf-mode 1)
            (setq recentf-max-saved-items 300)
            (setq recentf-max-menu-items 20)
            )
  )

(use-package exec-path-from-shell
  :ensure
  :config (progn
            (exec-path-from-shell-initialize)
            )
  )

(use-package password-store
  :config (progn
            )
  )
(use-package gitlab
  :config (progn
            (setq gitlab-host "https://lab.cluster.gsi.dit.upm.es"
                  gitlab-username "balkian"
                  )
            )
  )

(use-package docker
  :config (progn
            )
  )

(setq PREVSHELL (getenv "SHELL")) ;; Workaround for tramp
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
(setq tramp-default-method "ssh")

;; Don't clover my folders
(setq
   backup-by-copying t      ; don't clobber symlinks
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" , temporary-file-directory t)))
;; Prevent #file#.txt files
(setq create-lockfiles nil)

;; Path
(setenv "PATH" (concat (getenv "PATH") ":" (getenv "HOME") "/.bin" ":" (getenv "HOME") "/.local/bin"))
(setq exec-path (append exec-path (list (concat (getenv "HOME") "/.bin") (concat (getenv "HOME") ".local/bin") "/usr/bin")))

;; Launch terminal

(defun open-terminal ()
  (interactive)
  (call-process (or (getenv "XTERMINAL") "xterm") nil 0 nil "-e" PREVSHELL))
;; This does not work: (concat "echo -c 'cd " default-directory "'"))

(global-set-key (kbd "C-c t") 'open-terminal)

(provide '.init)
;;; init.el ends here
