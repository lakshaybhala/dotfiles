;;; Appearance settings, such as theme loading, disabling ugly UI
;;; elements, and maximising the frame.

(defun light-mode ()
  "Change the theme to a light theme."
  (interactive)
  (load-theme 'sanityinc-tomorrow-day))

(defun dark-mode ()
  "Change the theme to a dark theme."
  (interactive)
  (load-theme 'sanityinc-tomorrow-night))

;; Turn off the menu bar, scroll bar, and tool bar in GUI emacs,
;; because they're incredibly ugly and I don't need them.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; GUI mode-only settings
(when (display-graphic-p)
  ;; Load the light theme.
  (light-mode)
  ;; When GUI emacs opens, maximise it.
  (add-to-list 'initial-frame-alist '(fullscreen . maximized))
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

;; Don't display the start screen when opening emacs
(setq inhibit-startup-screen t)

(provide 'appearance)

;;; appearance.el ends here
