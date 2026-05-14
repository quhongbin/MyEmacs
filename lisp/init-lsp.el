(use-package haskell-mode
  :ensure t)
(use-package lsp-haskell)
;; 提前声明 markdown-mode，让 lsp-mode 能找到它
(use-package lsp-mode
  :ensure t
  :hook ((haskell-mode python-mode c++-mode rust-mode go-mode zig-mode c-mode) . lsp-deferred)
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

(provide 'init-lsp)
