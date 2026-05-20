;;; -*- lexical-binding: t; -*-
(require 'use-package)
;; ==========================
(org-babel-do-load-languages 'org-babel-load-languages
			     '((C . t)
			       (python . t)))



;; ==============================================
;; Org 渲染 & 美化 独立配置（优化版）
;; 依赖：org-modern, emacs 内置 org
;; ==============================================
;; org preview
(use-package org-preview-html
  :ensure t
  :config
  (setq org-preview-html-refresh-configuration 'save
	;;org-preview-html-timer-interval 2
	org-preview-html-viewer 'xwidget))
;;  (setq browse-url-browser-function 'browse-url-generic
;;	browse-url-generic-program "google-chrome-stable"))

;; 行内实时渲染 Org（所见即所得）
(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode)
  :config
  ;; 自动渲染：加粗、斜体、下划线、删除线、链接、图片、公式
  (setq org-appear-autolinks t)
  (setq org-appear-autosubmarkers t)
  (setq org-appear-autoemphasis t)
  (setq org-appear-autotags t)

  ;; 公式行内渲染（光标离开就显示）
  (setq org-preview-latex-default-density 2.0)
  (setq org-startup-with-latex-preview t)

  ;; 标题缩进美化
  ;;(setq org-startup-indented t)
  (setq org-hide-emphasis-markers t)) ; 隐藏 * = / 等标记

;; ------------------------------
;; org-roam configration
;; ------------------------------ 
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :config
  (org-roam-setup))

(use-package org-roam-ui
  :ensure t
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
	org-roam-ui-follow t
	org-roam-ui-update-on-save t))

;; 符号美化（内置 prettify-symbols-mode）
(add-hook 'org-mode-hook #'prettify-symbols-mode)

;; ------------------------------
;; mermaid
;; -----------------------------
;;(use-package mermaid-mode
;;  :ensure t)
;;(use-package ob-mermaid
;;  :ensure t
;;  :config
;;  (org-babel-do-load-languages
;;   'org-babel-load-languages
;;   '((mermaid . t))))
;;
;; ------------------------------
;; org template
;; ------------------------------
(require 'org-tempo)


;; ------------------------------
;; org 
;; ------------------------------
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
;;(setq org-src-block-faces '#777777)

(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook (lambda () (face-remap-add-relative 'fixed-pitch :family "JetBrains Mono")))
;; 代码块保持等宽


;; ------------------------------
;; 自定义 TODO 状态与配色
;; ------------------------------
(setq org-todo-keywords
      '((sequence
         "TODO(t)"
         "DOING(i)"
         "WAIT(w)"
         "DONE(d)"
         "CANC(c@)")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "#ff5555" :weight bold))
        ("DOING" . (:foreground "#ffcc00" :weight bold))
        ("WAIT" . (:foreground "#82aaff" :weight bold))
        ("DONE" . (:foreground "#4ade80" :weight bold))
        ("CANC" . (:foreground "#6c757d" :strike-through t))))

;; ------------------------------
;; 代码块渲染增强
;; ------------------------------
(setq org-src-preserve-indentation t)

;; ------------------------------
;; 图片 & LaTeX 公式实时预览
;; ------------------------------
(setq org-startup-with-inline-images t
      org-image-actual-width 650
      org-image-max-width 900)

;; LaTeX 高清矢量预览
(setq org-startup-with-latex-preview t
      org-latex-preview-default-scale 1.3
      org-latex-preview-dvisvgm-extra-args '("-b" "white"))

;; ------------------------------
;; 导出优化
;; ------------------------------
;; HTML 导出暗黑风格
;;(setq org-html-head-extra
;;      "<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown-dark.min.css'>
;;<style>
;;.markdown-body { max-width: 920px; margin: 0 auto; padding: 2rem; }
;;</style>")
(setq org-html-htmlize-output-type 'css)

;; PDF 用 XeLaTeX 编译（中文支持）
(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode %f"
        "xelatex -interaction nonstopmode %f"))

;; ------------------------------
;; 配置提供
;; ------------------------------
(provide 'init-org)
