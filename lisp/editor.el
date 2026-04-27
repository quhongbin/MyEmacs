;; start up auto complete pair of symbols
(electric-pair-mode 1)

;; ------------------------------
;; termianl config
;; ------------------------------
(setq explicit-shell-file-name "/bin/zsh")

;; vterm high performance shell plugin
;; dependency on libvterm and need to compile
(if (zerop (call-process "pkg-config" nil nil nil "--exists" "vterm"))
    (use-package vterm
      :ensure t
      :config
      (setq vter-shell "/bin/zsh")
      (global-set-key (kbd "C-x t") #'open-terminal-assembly))
  
  (message "libvterm is not exist"))

;; termianl-here outside terminal plugin
(use-package terminal-here
  :ensure t
  :config
  (global-set-key (kbd "C-x T") #'open-terminal-outside-shell))

;;turn on which key
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 0.1))

(provide 'editor)
