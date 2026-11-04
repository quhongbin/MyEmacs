;; -*- lexical-binding: t; -*-
(setq evil-want-keybinding nil)
(setq evil-want-integration t)

(use-package evil
  :ensure t
  :config
  (evil-mode 0))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode))

;;(use-package evil-easymotion
;;  :ensure t
;;  :config
;;  (evilem-default-keybindings "SPC")) 
(provide 'init-evil)
