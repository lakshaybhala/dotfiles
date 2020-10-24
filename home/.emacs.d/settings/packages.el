;;; Define a list of packages and install them if needed.

(require 'package)

;; Add melpa to package repos
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; List of packages to be installed
(defvar package-list '(auctex color-theme-sanityinc-tomorrow company-sourcekit dumb-jump ebib
    fish-mode github-modern-theme latex-pretty-symbols latex-preview-pane markdown-mode
    multiple-cursors pdf-tools rust-mode sass-mode scss-mode swift-mode toml-mode yaml-mode)
    "A list of packages to install at startup.")

;; Initialise packages
(package-initialize)

;; Refresh packages before attempting to install
(unless package-archive-contents
  (package-refresh-contents))

;; For each package in the list...
(dolist (package package-list)
  ;; ...if the package isn't installed...
  (unless (package-installed-p package)
    ;; ...install it
    (package-install package)))

(provide 'packages)

;;; packages.el ends here
