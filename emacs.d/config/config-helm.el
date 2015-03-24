;;; Helm
(helm-mode 1)

(require 'projectile)
(require 'helm-projectile)
(require 'helm-locate)
(require 'helm-config)
(require 'helm-misc)
(require 'helm-locate)
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)


;; Config
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z
(define-key helm-grep-mode-map (kbd "<return>") 'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n") 'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p") 'helm-grep-mode-jump-other-window-backward)

;; Better helm fonts
(set-face-attribute 'helm-selection nil :background "gold" :foreground "black")

;;; Evil helm
(define-key evil-normal-state-map (kbd "C-p") 'helm-mini)
(define-key evil-normal-state-map (kbd "SPC") 'helm-M-x)
(define-key evil-normal-state-map (kbd ",f") 'helm-occur)
(define-key evil-normal-state-map (kbd ",a") 'helm-ag)
(define-key evil-normal-state-map (kbd ",p") 'helm-show-kill-ring)

;;; Keyboard
(global-set-key (kbd "M-x") 'helm-M-x)
(define-key helm-map (kbd "C-w") 'backward-kill-word) 

(provide 'config-helm)
