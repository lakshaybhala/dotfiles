;;; macOS-specific settings.

;; Make sure that the left option key is treated as meta, and the
;; right option key is treated as alt. This is necessary on macOS,
;; when using a UK keyboard layout, in order to both type M in key
;; chords and also type characters such as #, which require the option
;; key.
(setq ns-alternate-modifier 'meta)
(setq ns-right-alternate-modifier 'none)

;; Both PATH and exec-path need to be modified here. PATH is used when
;; running shell-out commands, but exec-path is used by emacs itself.
;; See https://www.emacswiki.org/emacs/ExecPath for more info.

;; Get the path to ~/.cargo/bin
(setq cargo-bin (concat (getenv "HOME")
			"/.cargo/bin"))

;; Add /usr/local/bin, /Library/TeX/texbin/, and ~/.cargo/bin to both
;; PATH and exec-path

(setenv "PATH"
	(concat cargo-bin
		":/Library/TeX/texbin/:/usr/local/bin/:"
		(getenv "PATH")))

(setq exec-path (append (cons cargo-bin '("/Library/TeX/texbin/" "/usr/local/bin"))
			exec-path))

;; GUI mode-only settings
(when (display-graphic-p)
  ;; Set font, including font size
  (set-face-attribute 'default nil :font "Iosevka Expanded Alternate-12")
  (set-face-attribute 'default nil :weight 'extra-light))

(provide 'macos)

;;; macos.el ends here
