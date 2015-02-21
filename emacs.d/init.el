;; BalkEmacs --- My emacs configuration
;;; Commentary:

;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

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
  ; escreen            			; screen for emacs, C-\ C-h
   switch-window			; takes over C-x o
   auto-complete			; complete as you type with overlays
  ; zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
   emmet-mode
   pretty-mode
   evil
   fill-column-indicator
   evil-jumper
   evil-matchit
   evil-nerd-commenter
   evil-surround
   jedi
   flycheck
   powerline
   ein
   ;; smex
   helm
   projectile
   helm-projectile
   auctex
   gist
   markdown-mode
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

(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)
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

(require 'evil-matchit)
(global-evil-matchit-mode 1)


(require 'powerline)
(powerline-center-evil-theme)
(display-time-mode t)

(setq evil-default-cursor t)

;; No tabs, only 4 spaces, as default
(setq-default indent-tabs-mode nil)
(setq tab-width 4)


;; Disable splash screen
(setq inhibit-splash-screen t)

(set-default 'truncate-lines t)

(savehist-mode 1)

;; Parenthesis
(show-paren-mode t)

(add-to-list 'load-path (concat user-emacs-directory "config"))
(eval-after-load 'ein-notebooklist
                 '(require 'config-ein))

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

;; Scrolling in tmux
(xterm-mouse-mode)

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

;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("c3c0a3702e1d6c0373a0f6a557788dfd49ec9e66e753fb24493579859c8e95ab" "9b41f298ad28dc56765b227e4b9ed38f98a236706a3a26b148491a0dade90568" "0eebf69ceadbbcdd747713f2f3f839fe0d4a45bd0d4d9f46145e40878fc9b098" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ein:cell-input-area ((t nil)) t))
