; BalkEmacs --- My emacs configuration
;;; Commentary:

;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(setq package-enable-at-startup nil)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(setq evil-want-C-u-scroll t)

(setq el-get-sources  
      '((:name molokai-theme
               :type github  
               :pkgname "hbin/molokai-theme"
               :load "molokai-theme.el")))

(setq
 my:el-get-packages
 '(el-get				; el-get is self-hosting
   ace-jump-mode
   auctex
   auctex-latexmk
   auto-complete			; complete as you type with overlays
   ein
   emmet-mode
  ; escreen            			; screen for emacs, C-\ C-h
   evil
   evil-jumper
   evil-matchit
   evil-nerd-commenter
   evil-surround
   fill-column-indicator
   flycheck
   gist
   helm
   helm-ag
   helm-projectile
   helm-pydoc
   jedi
   magit
   markdown-mode
   nxhtml
   nose
   pivotal-tracker
   powerline
   pretty-mode
   projectile
   ;; smex
   switch-window			; takes over C-x o
   yasnippet
  ; zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
   ;; color-theme-solarized
   ;; color-theme-tango))	                ; check out color-theme-olarized

   ;; install new packages and init already installed packages
))

(setq my:el-get-packages
      (append my:el-get-packages
              (mapcar #'el-get-source-name el-get-sources)))

(require 'el-get-elpa)
(unless (file-directory-p el-get-recipe-path-elpa)
  (el-get-elpa-build-local-recipes))

(el-get 'sync my:el-get-packages)

(set-default-font "DejaVu Sans Mono")

(evil-mode)
;;(color-theme-solarized-dark)
;(load-theme 'soothe t)
;;(require 'monokai-theme)
(load-theme 'molokai t)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'ido)
(ido-mode t)

;;(require 'autopair)
;;(autopair-global-mode) ;; to enable in all buffers

;; SMEX, improvement of M-X
;;(global-set-key (kbd "M-x") 'smex)
;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
;;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;(setq completion-cycle-threshold t)

(helm-mode 1)
(define-key evil-normal-state-map (kbd "C-p") 'helm-mini)

(require 'evil-nerd-commenter)
(evilnc-default-hotkeys)

(defun toggle-current-window-dedication ()
 (interactive)
 (let* ((window    (selected-window))
        (dedicated (window-dedicated-p window)))
   (set-window-dedicated-p window (not dedicated))
   (message "Window %sdedicated to %s"
            (if dedicated "no longer " "")
            (buffer-name))))

(global-set-key [pause] 'toggle-current-window-dedication)

(require 'linum)
(global-linum-mode 1)
(set-face-attribute 'linum nil :height 100 :foreground "#666")
(setq linum-format " %d ")
(set-face-background 'hl-line-face "gray18")

(setq linum-mode-inhibit-modes-list '(eshell-mode
                                      shell-mode
                                      ein:notebook-bg-mode
                                      ein:bg/ein:notebook
                                      ein:bg
                                      ein:notebook
                                      )
)

(defadvice linum-on (around linum-on-inhibit-for-modes)
  "Stop the load of linum-mode for some major modes."
    (unless (member major-mode linum-mode-inhibit-modes-list)
      ad-do-it))

(ad-activate 'linum-on)

(require 'evil-matchit)
(global-evil-matchit-mode 1)


(require 'powerline)
(powerline-center-evil-theme)
(display-time-mode t)

(setq evil-default-cursor t)

;; No tabs, only 4 spaces, as default
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq default-tab-width 4); 


;; Disable splash screen
(setq inhibit-splash-screen t)

(set-default 'truncate-lines nil)
(setq truncate-partial-width-windows nil)


(savehist-mode 1)

;; Parenthesis
(show-paren-mode t)

(add-to-list 'load-path (concat user-emacs-directory "config"))
(eval-after-load 'ein-notebooklist
                 '(require 'config-ein))

;; Latex
(require 'config-latex)

;; Latex
(require 'config-python)
;; Cool surrounding

(require 'evil-surround)
(global-evil-surround-mode 1)

;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(require 'helm-config)
(require 'helm-misc)
(require 'helm-locate)
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)

(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)


(require 'projectile)
(require 'helm-locate)

(define-key evil-normal-state-map (kbd ",f") 'helm-occur)

;; Better jumping
(require 'evil-jumper)
(global-evil-jumper-mode)

(provide '.emacs)

;; cool jumping
(define-key evil-normal-state-map (kbd "SPC") 'helm-M-x)
(define-key evil-normal-state-map (kbd "[b") 'evil-next-buffer)
(define-key evil-normal-state-map (kbd "]b") 'evil-prev-buffer)
(define-key evil-normal-state-map (kbd ",,") 'evil-ace-jump-char-mode)


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


(global-hl-line-mode)

;; (autoload 'markdown-mode "markdown-mode"
;; "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(toggle-indicate-empty-lines)

(require 'fill-column-indicator)
(setq fci-rule-column 79)
(fringe-mode '(1 . 1))

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-directory "~/Dropbox/org")
(setq org-mobile-inbox-for-pull "~/Dropbox/org/inbox.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-mobile-files '("~/Dropbox/org"))
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files (list org-directory))

(define-key global-map "\C-cc" 'org-capture)

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)


(yas-global-mode 1)

(require 'config-secret)

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (set-face-background 'magit-item-highlight "black")))

;; Preven #file#.txt files
(setq create-lockfiles nil)

;; Better helm fonts
(set-face-attribute 'helm-selection nil :background "yellow" :foreground "black")

;; Scrolling in tmux
(defun my-terminal-config (&optional frame)
  "Establish settings for the current terminal."
  (if (not frame) ;; The initial call.
      (xterm-mouse-mode 1)
    ;; Otherwise called via after-make-frame-functions.
    (if xterm-mouse-mode
        ;; Re-initialise the mode in case of a new terminal.
        (xterm-mouse-mode 1))))
;; Evaluate both now (for non-daemon emacs) and upon frame creation
;; (for new terminals via emacsclient).
(my-terminal-config)

(add-hook 'after-make-frame-functions 'my-terminal-config)

;; Don't use evil mode in magit

(add-to-list 'evil-emacs-state-modes 'git-rebase-mode)

;; Disable copying to the clipboard
;; (setq x-select-enable-clipboard nil)
;; (setq x-select-enable-primary t)

(setq flycheck-temp-prefix ".flycheck")

;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "c3c0a3702e1d6c0373a0f6a557788dfd49ec9e66e753fb24493579859c8e95ab" "9b41f298ad28dc56765b227e4b9ed38f98a236706a3a26b148491a0dade90568" "0eebf69ceadbbcdd747713f2f3f839fe0d4a45bd0d4d9f46145e40878fc9b098" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(default ((t (:inherit nil :stipple nil :background "#1b1d1e" :foreground "#f8f8f0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight semi-light :height 113 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 ;; '(ein:cell-input-area ((t nil)))
 '(ein:cell-input-prompt ((t (:inherit header-line :background "firebrick"))))
)
