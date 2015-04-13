;;; BalkEmacs --- My emacs configuration
;;; Commentary:

;;; Config that needs to be loaded before require
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "c3c0a3702e1d6c0373a0f6a557788dfd49ec9e66e753fb24493579859c8e95ab" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq evil-want-C-u-scroll t)

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
   evil-leader
   evil-matchit
   evil-nerd-commenter
   evil-numbers
   evil-org-mode
   evil-surround
   exec-path-from-shell
   fill-column-indicator
   flycheck
   gist
   git-gutter-fringe
   guide-key
   helm
   helm-ag
   helm-projectile
   helm-pydoc
   helm-swoop
   jedi
   magit
   markdown-mode
   neotree
   nxhtml
   nose
   pivotal-tracker
   popwin
   pretty-mode
   projectile
   ;; smex
   smart-mode-line
   switch-window			; takes over C-x o
   undo-tree
   vimrc-mode
   volatile-highlights
   yaml-mode
   yasnippet
   zygospore
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


;;(color-theme-solarized-dark)
;(load-theme 'soothe t)
;;(require 'monokai-theme)
(load-theme 'molokai t)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;(setq completion-cycle-threshold t)

;;; Neotree
(require 'neotree)
(setq projectile-switch-project-action 'neotree-projectile-action)
(when neo-persist-show
  (add-hook 'popwin:before-popup-hook
            (lambda () (setq neo-persist-show nil)))
  (add-hook 'popwin:after-popup-hook
            (lambda () (setq neo-persist-show t))))

;;; Popwin
(require 'popwin)
(popwin-mode)

;;; Linum
(require 'linum)
(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format 'dynamic)
(set-face-attribute 'linum nil :height 90)

(setq highlight-color "#232323")

;;; Show column number
(column-number-mode)

;;; Highlight line
(global-hl-line-mode)
(set-face-background 'hl-line highlight-color)

;;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-temp-prefix ".flycheck")

;; (global-linum-mode 1)
;; (setq linum-mode-inhibit-modes-list '(eshell-mode
;;                                       helm-buffer
;;                                       shell-mode
;;                                       ein:notebook-bg-mode
;;                                       ein:bg/ein:notebook
;;                                       ein:bg
;;                                       ein:notebook
;;                                       ))
;; (defadvice linum-on (around linum-on-inhibit-for-modes)
;;   "Stop the load of linum-mode for some major modes."
;;     (unless (member major-mode linum-mode-inhibit-modes-list)
;;       ad-do-it))
;; (ad-activate 'linum-on)
(add-hook 'prog-mode-hook 'fci-mode)

;; (require 'powerline)
;; (powerline-center-evil-theme)

(sml/setup)
(sml/apply-theme 'dark)

(display-time-mode t)

;;; Global emacs settings
;; disable splash screen
(setq inhibit-splash-screen t)
(setq truncate-partial-width-windows nil)
(set-default 'truncate-lines nil)
;; No tabs, only 4 spaces, as default
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq default-tab-width 4); 
;; Show info about available commands
(setq guide-key/guide-key-sequence '("SPC" ","))

;; Separate Configs
(add-to-list 'load-path (concat user-emacs-directory "config"))
(require 'config-latex)
(require 'config-python)
(eval-after-load 'ein-notebooklist
                 '(require 'config-ein))
(require 'config-helm)
(require 'config-evil)
(require 'config-org)
(require 'config-secret)
(require 'config-dired)

;;; Global modes
(tool-bar-mode 0)
(savehist-mode 1)
(show-paren-mode t)
(yas-global-mode 1)
(guide-key-mode 1)
(scroll-bar-mode 0)

;;; Specific modes
;; (autoload 'markdown-mode "markdown-mode"
;; "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;
;; Global Keybindings
;; 
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key [escape] 'keyboard-escape-quit) 
(define-key helm-map (kbd "C-w") 'backward-kill-word) 
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)

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
;; Preven #file#.txt files
(setq create-lockfiles nil)

(setq inhibit-startup-message t)

(toggle-indicate-empty-lines)

;;; Columns
(require 'fill-column-indicator)
(setq fci-rule-column 79)
(setq fci-rule-color highlight-color)
(setq fci-rule-width 3)

(fringe-mode '(5 . 5))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (set-face-background 'magit-item-highlight "black")))

;; Fix Scrolling in tmux
;; Set the default font too
(defun client-config (&optional frame)
  "Establish settings for the current terminal."
  (if (not frame) ;; The initial call.
      (xterm-mouse-mode 1)
    ;; Otherwise called via after-make-frame-functions.
    (if xterm-mouse-mode
        ;; Re-initialise the mode in case of a new terminal.
        (xterm-mouse-mode 1))))
;; Evaluate both now (for non-daemon emacs) and upon frame creation
;; (for new terminals via emacsclient).
(client-config)
(add-hook 'after-make-frame-functions 'client-config)

(defun toggle-current-window-dedication ()
 (interactive)
 (let* ((window    (selected-window))
        (dedicated (window-dedicated-p window)))
   (set-window-dedicated-p window (not dedicated))
   (message "Window %sdedicated to %s"
            (if dedicated "no longer " "")
            (buffer-name))))

(global-set-key [insert] 'toggle-current-window-dedication)


;; Disable copying to the clipboard
;; (setq x-select-enable-clipboard nil)
;; (setq x-select-enable-primary t)

;;; Show human sizes in dired
(setq-default dired-listing-switches "-alhv")

(defalias 'yes-or-no-p 'y-or-n-p)

;;; Winner
;;; History of visited windows
;;; C-<left>, C-<right>
(when (fboundp 'winner-mode)
    (winner-mode 1))

(exec-path-from-shell-initialize)

(require 'git-gutter-fringe)
(setq git-gutter-fr:side 'right-fringe)

;; set a default font
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10"))
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

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 300)
(setq recentf-max-menu-items 20)


(provide '.emacs)
