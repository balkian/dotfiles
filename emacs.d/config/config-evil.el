;;
;; Evil and keybindings
;;
(evil-mode)
(require 'evil-nerd-commenter)
(require 'evil-matchit)
(require 'evil-surround)
(require 'evil-jumper)

;; Evil global modes 
(global-evil-matchit-mode 1)
(global-evil-jumper-mode)
(global-evil-surround-mode 1)

;; Evil global modes config
(evilnc-default-hotkeys)
(setq evil-default-cursor t)

;; Exclude modes from evil mode
(add-to-list 'evil-emacs-state-modes 'git-rebase-mode)
(add-to-list 'evil-emacs-state-modes 'undo-tree-visualizer-mode)
(add-to-list 'evil-emacs-state-modes 'neotree-mode)

;;
;; Evil keys 
;; cool jumping

(define-key evil-normal-state-map (kbd "[b") 'evil-next-buffer)
(define-key evil-normal-state-map (kbd "]b") 'evil-prev-buffer)
(define-key evil-normal-state-map (kbd "s") 'evil-ace-jump-char-mode)
(define-key evil-normal-state-map (kbd ",d") 'neotree-toggle)

(define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(provide 'config-evil)
