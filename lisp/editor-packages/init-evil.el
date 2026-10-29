;; -*- lexical-binding: t; -*-
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode))

;;(use-package evil-easymotion
;;  :ensure t
;;  :config
;;  (evilem-default-keybindings "SPC")) 
(provide 'init-evil)
