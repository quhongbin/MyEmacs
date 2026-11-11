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
;;(require 'init-magit)
(require 'init-editor)
(require 'init-theme)
(require 'init-lsp)
(require 'init-org)
(require 'init-markdown)

;;(add-to-list 'load-path "~/.emacs.d/lisp/editor-packages/")
;;(require 'treemacs)
;;(require 'yasnippet)
;;

;;; Selection and Cursor Line

;; Enable current line highlighting
(global-hl-line-mode 1)

;; Selected region
(set-face-attribute 'region nil
                    :foreground "#ebdbb2"
                    :background "#504945")

;; Current line: 使用温和背景色高亮，禁止下划线
(set-face-attribute 'hl-line nil
                    :background "#32302f"
                    :underline nil
                    :extend t)

;; Cursor: 占据一个字符宽度的实心方块光标，不要下划线
(setq-default cursor-type 'box)
(setq-default cursor-in-non-selected-windows 'hollow)
(set-face-attribute 'cursor nil
                    :background "#bdae93")

;; Evil 模式下（若开启）各状态也均保持为一个字符宽度的方块光标，杜绝下划线
(with-eval-after-load 'evil
  (setq evil-default-cursor 'box
        evil-normal-state-cursor 'box
        evil-insert-state-cursor 'box
        evil-visual-state-cursor 'box
        evil-motion-state-cursor 'box
        evil-replace-state-cursor 'box
        evil-operator-state-cursor 'box
        evil-emacs-state-cursor 'box))


;; 定义一个标志位，防止重复加载
(defvar my-gui-packages-loaded-p nil)

(defun my-setup-gui-plugins (&optional frame)
  "配置仅在图形界面下运行的插件，如 EAF"
  ;; 只有在是图形界面且尚未加载过时才执行
  (when (and (display-graphic-p frame)
             (not my-gui-packages-loaded-p))
    
    (message "检测到图形界面，正在加载 EAF 及 GUI 组件...")

    ;; --- EAF 配置开始 ---
;;    (add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
;;	(require 'eaf)
;;	(require 'eaf-browser)
;;	(require 'eaf-pdf-viewer)
;;	(require 'eaf-image-viewer)
;;	(require 'eaf-terminal)
;;	(require 'eaf-markdown-previewer)
;;	(require 'eaf-org-previewer)
;;	(require 'eaf-mindmap)
;;	(require 'eaf-jupyter)
;;	(require 'eaf-pyqterminal)

;;    ;; --- EAF 配置结束 ---
;;
;;    ;; 设置标志位，确保即使开启多个 Client 也不会重新 require
    (setq my-gui-packages-loaded-p t)))
;;
;;;; 场景 1: 处理正常启动 (emacs ~/test)
(if (daemonp)
;;    ;; 场景 2: 处理 daemon 模式下的 client 连接
    (add-hook 'after-make-frame-functions #'my-setup-gui-plugins)
;;  ;; 如果不是 daemon，直接在界面初始化完成后加载
  (add-hook 'window-setup-hook #'my-setup-gui-plugins))
;;;;gemini ai generator


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ai-code-onboarding-seen t)
 '(font-use-system-font t)
 '(package-selected-packages
   '(ai-code auctex cdlatex company consult-lsp doom-themes flycheck
	     go-mode grip-mode gruvbox-theme haskell-mode
	     impatient-mode kaomel lsp-haskell lsp-ui magit move-text
	     nix-mode org-appear org-download org-modern
	     org-preview-html org-roam-ui ox-hugo pandoc-mode
	     pyim-basedict python-mode rust-mode terminal-here
	     treemacs vertico vterm yasnippet zig-mode))
 '(safe-local-variable-values
   '((org-roam-directory . "~/CPP_LEARNING/")
     (org-roam-db-location . "~/Obsidian/CPP_LEARNING/.org-roam.db")
     (org-roam-directory . "~/Obsidian/CPP_LEARNING/")
     (org-roam-db-location . "~/CPP_LEARNING/.org-roam.db"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "JB" :slant normal :weight regular :height 120 :width normal))))
 '(markdown-header-face-1 ((t (:inherit (outline-1 bold) :height 1.4))))
 '(markdown-header-face-2 ((t (:inherit (outline-2 bold) :height 1.3))))
 '(markdown-header-face-3 ((t (:inherit (outline-3 bold) :height 1.2))))
 '(markdown-header-face-4 ((t (:inherit (outline-4 bold) :height 1.1))))
 '(markdown-header-face-5 ((t (:inherit (outline-5 bold) :height 1.05))))
 '(markdown-header-face-6 ((t (:inherit (outline-6 bold) :height 1.0))))
 '(markdown-inline-code-face ((((background dark)) :inherit fixed-pitch :background "#32302f" :foreground "#fabd2f") (((background light)) :inherit fixed-pitch :background "#ebdbb2" :foreground "#b57614") (t :inherit fixed-pitch :background "#3c3836" :foreground "#ebdbb2"))))
(put 'set-goal-column 'disabled nil)
