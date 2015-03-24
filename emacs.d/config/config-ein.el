(evil-define-key 'normal ein:notebooklist-mode-map
  "r" 'ein:notebooklist-reload
  "q" 'bury-buffer)

(evil-define-key 'normal ein:notebook-mode-map
  ",w" 'ein:notebook-save-notebook-command
  ",cc" 'ein:worksheet-execute-cell
  ",e" 'ein:worksheet-clear-output
  ",v" 'ein:worksheet-set-output-visibility-all
  ",l" 'ein:worksheet-clear-output
  ",L" 'ein:worksheet-clear-all-output
  ",d" 'ein:worksheet-kill-cell
  ",y" 'ein:worksheet-copy-cell
  ",p" 'ein:worksheet-yank-cell
  ",O" 'ein:worksheet-insert-cell-above
  ",o" 'ein:worksheet-insert-cell-below
  "]e" 'ein:notebook-worksheet-move-next
  "[e" 'ein:notebook-worksheet-move-rev
  ",t" 'ein:worksheet-toggle-cell-type
  ",u" 'ein:worksheet-change-cell-type
  ",s" 'ein:worksheet-split-cell-at-point
  ",m" 'ein:worksheet-merge-cell
  "\C-n" 'ein:worksheet-goto-next-input
  "\C-p" 'ein:worksheet-goto-prev-input
  (kbd "<C-return>") 'ein:worksheet-execute-cell)

(evil-define-key 'insert ein:notebook-mode-map
  (kbd "<C-return>") 'ein:worksheet-execute-cell)

(defun ipybackground ()
  (interactive)
  ;(setq prevfg (face-attribute 'default :foreground))
  (face-remap-add-relative 'ein:cell-input-area :background (face-attribute 'default :background))
  ;(face-remap-add-relative 'default :background "#ffffff")
   (setq buffer-face-mode-face '(:background "#343434"))
   (buffer-face-mode))


(add-hook
  'ein:notebook-mode-hook 'ipybackground)

;; (add-hook
;;   'ein:notebook-mode-hook '(linum-mode 0))

(setq ein:notebook-modes '(ein:notebook-mumamo-mode ein:notebook-plain-mode))

(setq mumamo-background-colors nil)

(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars)))) 

(provide 'config-ein)
