;; 提前声明 markdown-mode，让 lsp-mode 能找到它
(use-package lsp-mode
  :ensure t
  :hook ((python-mode c++-mode rust-mode go-mode zig-mode c-mode) . lsp-deferred)
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c L"))

(use-package company
  :ensure t
  :config
  (global-company-mode 1))

(provide 'init-lsp)
