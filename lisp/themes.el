(package-initialize)

(unless (package-installed-p 'gruvbox-theme)
  (package-refresh-contents)
  (package-install 'gruvbox-theme))

(load-theme 'gruvbox t)
;;load theme
(provide 'themes)
