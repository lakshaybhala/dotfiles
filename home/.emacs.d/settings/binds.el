;;; Custom keybindings and, if necessary, the functions they run.

;; Define a function for indenting a region
(defun my-indent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

;; Define a function for unindenting a region
(defun my-unindent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -4))
	     (setq deactivate-mark nil))
    (self-insert-command N)))

;; Indent with C-x ]
(global-set-key (kbd "C-x ]") 'my-indent-region)
;; Unindent with C-x [
(global-set-key (kbd "C-x [") 'my-unindent-region)

;; Define a function for switching to the previous window
(defun prev-window ()
  (interactive)
  (other-window -1))

;; Switch to the next window with C-.
(global-set-key (kbd "C-.") #'other-window)
(global-set-key (kbd "C-c .") #'other-window)
;; Switch to the previous window with C-,
(global-set-key (kbd "C-,") #'prev-window)
(global-set-key (kbd "C-c ,") #'prev-window)

;; multiple-cursors
(require 'multiple-cursors)
;; Use C-S-c C-S-c to trigger multiple-cursors on the region
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; trigger ebib with C-c e
(global-set-key "\C-ce" 'ebib)

(provide 'binds)

;;; binds.el ends here
