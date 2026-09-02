;;; -*- lexical-binding: t; -*-
(require 'init-func)
;;move selected block
(use-package move-text
  :ensure t
  :bind
  (("M-p" . move-text-up)
   ("M-n" . move-text-down)))

;;----------------
;;auto save config
;;----------------
(auto-save-visited-mode t)

;;set auto-save interval time is 5
(setq auto-save-visited-interval 5)

;;set font family
(set-frame-font "JetBrainsMono Nerd Font Mono")

;;----------------
;;fixed margins
;;----------------
(setq scroll-margin 10)
(with-eval-after-load 'vterm
  (add-hook 'vterm-mode-hook (lambda()(setq-local scroll-margin 0))))


;; ------------------------------
;; auto backup config
;; ------------------------------
;;backup function
(setq make-backup-files t)
;; 自动保存后执行的钩子（可选）
(add-hook 'auto-save-hook
          (lambda () (message "Auto-saved at %s" (current-time-string))))
;;backup files config
(setq backup-directory-alist
      `(("." . ,(expand-file-name "~/.emacs.d/backup/")))) ;;add backup files directory


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
      (global-set-key (kbd "C-x t") #'vterm))
  
  (message "libvterm is not exist"))

;; termianl-here outside terminal plugin
(use-package terminal-here
  :ensure t
  :config
  (global-set-key (kbd "C-x T") #'terminal-here))

;;turn on which key
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 0.1))

(use-package pyim
  :ensure t
  :config
  (setq default-input-method "pyim")

  ;; 使用双拼
  (pyim-default-scheme 'ziranma-shuangpin)

  (global-set-key (kbd "C-\\") #'toggle-input-method))

(use-package pyim-basedict
  :ensure t
  :after pyim
  :config
  (pyim-basedict-enable))


;; load-path 必须用绝对路径：相对路径（如 "editor-packages/"）是按
;; default-directory（emacs 启动时所在的目录）解析的 —— 从 home 或项目目录
;; 启动 emacs 时根本找不到这个目录，require 就会报 "Cannot open load file"。
;; 这里用 load-file-name（本文件被加载时的绝对路径）定位 lisp/ 目录，
;; 再拼出 editor-packages 的绝对路径，任何目录下启动 emacs 都能正确加载。
(add-to-list 'load-path
             (expand-file-name "editor-packages"
                               (file-name-directory (or load-file-name buffer-file-name))))
;; 这里 require 的是 editor-packages/ 里的本地包装文件 init-treemacs /
;; init-yasnippet（feature 名与包名不同）。坑点：包装文件不能用与包相同的
;; 文件名 + (provide '包名)——那会插队遮蔽 elpa 里的真实包，且内层
;; use-package 触发的 (require '包名) 在 provide 执行前再次加载同一文件，
;; 报 "Recursive require"。同名包装文件已改名 init-*.el 规避。
(require 'init-treemacs)
(require 'init-yasnippet)
(provide 'init-editor)
