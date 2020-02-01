;;; Conditionally loads os-specific settings.

;; Check OS type
(cond
 ((string-equal system-type "darwin")
  (progn
    (message "macOS")
    (require 'macos))))

(provide 'os-specific)

;;; os-specific.el ends here
