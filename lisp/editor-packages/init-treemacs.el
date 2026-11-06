;;; -*- lexical-binding: t; -*-
;; 打开目录时（emacs DIR / C-x C-f DIR / C-x d），Emacs 会进入 dired-mode。
;; 这里把 treemacs 挂到 dired-mode-hook 上：自动在左侧边栏里显示该目录，
;; 并且 treemacs 里只保留这一个项目（与 treemacs-select-directory 的行为一致）。
(defun my-treemacs-open-directory ()
  "在左侧的 treemacs 侧边栏中显示当前 dired 缓冲区对应的目录。"
  (interactive)
  ;; treemacs 默认是延迟加载的（use-package 未 :demand），这里保证它已就绪
  (require 'treemacs)
  (let* ((dir (file-name-as-directory default-directory))
         (path (treemacs-canonical-path dir))
         (name (file-name-nondirectory (directory-file-name path))))
    ;; treemacs 会把焦点抢到侧边栏；save-selected-window 把它还原回 dired 窗口，
    ;; 否则 find-file 收尾时 switch-to-buffer 会把 dired 缓冲区显示到侧边栏里。
    (save-selected-window
      (if (fboundp 'treemacs--show-single-project)
          (treemacs--show-single-project path name)
        (treemacs-add-project-to-workspace path name)
        (treemacs-select-window)))))

(use-package treemacs
  :ensure t
  :init
  ;; 目录打开时自动在左侧显示 treemacs
  (add-hook 'dired-mode-hook #'my-treemacs-open-directory)
  :config
  (global-set-key (kbd "C-x e") 'treemacs) ;;global key bind
  (setq treemacs-follow-after-init t  ;;follow current file
	treemacs-width 30
	treemacs-position 'left)) ;;侧边栏固定在左侧

(provide 'init-treemacs)
