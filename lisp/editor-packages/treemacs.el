(use-package treemacs
  :ensure t
  :config
  (global-set-key (kbd "C-x e") 'treemacs) ;;global key bind
  (setq treemacs-follow-after-init t  ;;follow current file
	treemacs-width 30)) ;;set width

(provide 'treemacs)
