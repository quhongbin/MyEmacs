(require 'init-func)
;;auto save config
(auto-save-visited-mode t)

;;set auto-save interval time is 5
(setq auto-save-visited-interval 5)


;;backup function
(setq make-backup-files t)
;; 自动保存后执行的钩子（可选）
(add-hook 'auto-save-hook
          (lambda () (message "Auto-saved at %s" (current-time-string))))
;;backup files config
(setq backup-directory-alist
      '(("." . ,(expand-file-name "~/.emacs.d/backup/")))) ;;add backup files directory


;;auto complete symbols e.g single quote
(electric-pair-mode 1)
(setq electric-pair-pairs
      '((?\< .?\>))
      )
;; ------------------------------
;; termianl config
;; ------------------------------
(init-func-ensure-program "zsh" "zsh")
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

(provide 'init-editor)
