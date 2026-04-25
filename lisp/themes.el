;;(unless (package-installed-p 'gruvbox-theme)
;;  (package-refresh-contents)
;;  (package-install 'gruvbox-theme))
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

;;load themes
(provide 'themes)
