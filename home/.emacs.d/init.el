;;; Initialisation file. Loads a number of other files from the
;;; settings/ subdirectory.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;
;; This was commented out because package-initialize is called in
;; 'packages.
;;
; (package-initialize)

;; Set path to settings directory

;; Get the full path to the settings directory (presumably at
;; ~/.emacs.d/settings/)
(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Allow loading of .el files from settings directory
(add-to-list 'load-path settings-dir)

;; Set the path to the Custom-settings file, used so that
;; custom-set-variables don't get messy in this file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; Load the Custom-settings file
(load custom-file)

;; Load packages
(require 'packages)

;; Load other settings files
(require 'appearance)
(require 'binds)
(require 'style)
(require 'editing)
(require 'os-specific)

;; GUI mode only.
(when (display-graphic-p)
  ;; Start the emacs server so that `emacsclient` can be used.
  (server-start))

;; Show a confirmation message
(message "Finished loading!")

;;; init.el ends here
