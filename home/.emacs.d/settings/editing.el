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

(provide 'editing)

;;; editing.el ends here
