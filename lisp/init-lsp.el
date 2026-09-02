;;; -*- lexical-binding: t; -*-
;; 提前声明 markdown-mode，让 lsp-mode 能找到它
(use-package python-mode
  :ensure t)
(use-package zig-mode
  :ensure t)
(use-package rust-mode
  :ensure t)
(use-package go-mode
  :ensure t)
(use-package haskell-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook ((python-mode c++-mode rust-mode go-mode zig-mode c-mode) . lsp-deferred)
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c L"))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  )

(use-package company
  :ensure t
  :config
  (global-company-mode 1)
  (setq company-minimum-prefix-length 2))

;; completetion framework UI plugin
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

;; search and locate commands
(use-package consult
  :ensure t)

(use-package consult-lsp
  :ensure t)

(add-hook 'prog-mode-hook #'yas-minor-mode)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package consult
  :ensure t)

(use-package consult-lsp
  :ensure t)

(provide 'init-lsp)
