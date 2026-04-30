;;(unless (package-installed-p 'gruvbox-theme)
;;  (package-refresh-contents)
;;  (package-install 'gruvbox-theme))
(if (package-installed-p 'doom-themes)
     (load-theme 'doom-gruvbox t)
  (use-package doom-themes
    :ensure t
    :config
    (load-theme 'doom-gruvbox t))
  )
;;load themes
(provide 'init-theme)
