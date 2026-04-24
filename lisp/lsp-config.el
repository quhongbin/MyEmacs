(use-package lsp-mode
  :ensure t
  :hook ((python-mode c++-mode rust-mode go-mode zig-mode) . lsp-deferred)
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")) ;; 设置lsp-mode的快捷键前缀

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(add-hook 'c-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook #'lsp-deferred)
(add-hook 'rust-mode-hook #'lsp-deferred)

(provide 'lsp-config)
