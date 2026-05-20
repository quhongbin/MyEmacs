;;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
;;(setq package-archives '(("gnu"   . "http://1.15.88.122/gnu/")
;;                          ("melpa" . "http://1.15.88.122/melpa/")
;;			   ("nongnu" . "http://1.15.88.122/nongnu")))

;;(setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                         ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;                         ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;;
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-editor)
(require 'init-theme)
(require 'init-lsp)
(require 'init-org)

;; gemini ai generator
;; 定义一个标志位，防止重复加载
(defvar my-gui-packages-loaded-p nil)

(defun my-setup-gui-plugins (&optional frame)
  "配置仅在图形界面下运行的插件，如 EAF"
  ;; 只有在是图形界面且尚未加载过时才执行
  (when (and (display-graphic-p frame)
             (not my-gui-packages-loaded-p))
    
    (message "检测到图形界面，正在加载 EAF 及 GUI 组件...")

    ;; --- EAF 配置开始 ---
    (add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
    (require 'eaf)
    ;; 建议使用这种方式批量加载，更简洁
    (dolist (app '(browser pdf-viewer image-viewer markdown-previewer 
                   org-previewer mindmap jupyter terminal))
      (require (intern (format "eaf-%s" app)) nil t))
    ;; --- EAF 配置结束 ---

    ;; 设置标志位，确保即使开启多个 Client 也不会重新 require
    (setq my-gui-packages-loaded-p t)))

;; 场景 1: 处理正常启动 (emacs ~/test)
(if (daemonp)
    ;; 场景 2: 处理 daemon 模式下的 client 连接
    (add-hook 'after-make-frame-functions #'my-setup-gui-plugins)
  ;; 如果不是 daemon，直接在界面初始化完成后加载
  (add-hook 'window-setup-hook #'my-setup-gui-plugins))
;;gemini ai generator


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("51fa6edfd6c8a4defc2681e4c438caf24908854c12ea12a1fbfd4d055a9647a3"
     default))
 '(package-selected-packages nil)
 '(safe-local-variable-values
   '((org-roam-directory . "~/CPP_LEARNING/")
     (org-roam-db-location . "~/Obsidian/CPP_LEARNING/.org-roam.db")
     (org-roam-directory . "~/Obsidian/CPP_LEARNING/")
     (org-roam-db-location . "~/CPP_LEARNING/.org-roam.db")
     (org-roam-directory . "~/CPP_LEARNING"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
