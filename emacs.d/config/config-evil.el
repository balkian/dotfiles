;;; config-evil.el --- Configuration for evil and its keybindings
;;; Commentary: 
;;; Code:
(evil-mode)
(require 'evil-leader)
(require 'evil-matchit)
(require 'evil-nerd-commenter)
(require 'evil-surround)

;; Evil global modes config
(evilnc-default-hotkeys)
(setq evil-default-cursor t)

;; Evil global modes 
(global-evil-matchit-mode 1)
(global-evil-surround-mode 1)
(global-evil-jumper-mode)
(global-evil-leader-mode)

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
;;
;; Evil keys 
(evil-leader/set-leader "<SPC>")

(define-key evil-normal-state-map (kbd "[b") 'previous-code-buffer)
(define-key evil-normal-state-map (kbd "]b") 'next-code-buffer)
(define-key evil-normal-state-map (kbd "s") 'evil-ace-jump-char-mode)
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

(provide 'config-evil)
;;; config-evil.el ends here
