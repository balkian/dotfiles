(setq TeX-auto-save t)
(setq TeX-parse-self t)

(setq-default TeX-master nil)

(setq TeX-view-program-list '(
;; ("Evince" "evince --page-index=%(outpage) %o"),
                            ("Okular" "okular --noraise --unique %o#src:%n%a")
))
;; (setq TeX-view-program-selection '((output-pdf "Evince")))
(setq TeX-view-program-selection '((output-pdf "Okular")))

(setq LaTeX-command "latex -synctex=1")

(setq TeX-source-correlate-method 'synctex)
;(setq TeX-one-master "<none>") ;; If you don't want emacs to write the variables to the file
(setq-default TeX-master nil) ;

;; Avoid questions :)
(defun build-view ()
  (interactive)
  (let ((TeX-save-query nil)) 
    (TeX-save-document (TeX-master-file)))
  (setq build-proc (TeX-command "LaTeX" 'TeX-master-file -1))
  (set-process-sentinel  build-proc  'build-sentinel)
)

(defun build-sentinel (process event)    
  (if (string= event "finished\n") 
    (TeX-view)
    (message "Errors! Check with C-`")))

(add-hook 'LaTeX-mode-hook '(lambda () (local-set-key (kbd "\C-c\C-c") 'build-view)))

(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'reftex-mode)

(provide 'config-latex)
