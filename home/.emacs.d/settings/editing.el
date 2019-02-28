;;; Editing settings (i.e. settings for packages that affect editing).

;; Turn on dumb jump mode
(dumb-jump-mode)
;; Prefer `rg` for searching
(setq dumb-jump-prefer-searcher 'rg)

;; AUCTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
; (setq TeX-PDF-mode t)

;; Remove trailing whitespace from lines
; (add-hook 'before-save-hook 'delete-trailing-whitespace)
;; Add a newline at the end of files
(setq require-final-newline t)

(provide 'editing)

;;; editing.el ends here
