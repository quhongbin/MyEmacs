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

(use-package nix-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook ((python-mode c++-mode rust-mode go-mode zig-mode c-mode nix-mode) . lsp-deferred)
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
  :ensure t

  )

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

(use-package imenu-list
  :ensure t
  :config
  ;; 在左下角显示 imenu-list（slot 1，位于 treemacs 下方）。
  ;; 本条目必须写在 :config 里（imenu-list 加载完成之后），
  ;; 这样它才会插到 imenu-list 自己注册的 display-buffer-alist 条目之前，
  ;; 覆盖其默认的 split-window 显示方式。
  (add-to-list 'display-buffer-alist
               '("\\*Ilist\\*"
                 display-buffer-in-side-window
                 (side . left)
                 (slot . 1)
                 (window-height . 0.35)
                 (window-width . 30)))
  ;; 在 lsp-mode 下自动显示 imenu-list（函数/符号大纲）
  (add-hook 'lsp-mode-hook (lambda () (imenu-list-minor-mode 1))))

(provide 'init-lsp)
