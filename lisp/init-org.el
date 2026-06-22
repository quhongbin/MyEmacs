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
;;  (setq org-startup-with-latex-preview t)

  ;; 标题缩进美化
  ;;(setq org-startup-indented t)
  (setq org-hide-emphasis-markers t)) ; 隐藏 * = / 等标记

;; ------------------------------
;; ox-hugo configuratio n
;; ------------------------------
(use-package ox-hugo
  :ensure t
  :after ox
  :config
  ;; 可选：如果你希望全局所有 Org-Hugo 文件都在保存时自动导出
  ;; (add-hook 'org-mode-hook #'org-hugo-auto-export-mode)
  )
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
;; org-babel
;; -----------------------------
;;(use-package mermaid-mode
;;  :ensure t)
;;(use-package ob-mermaid
;;  :ensure t
;;  :config
;;  (org-babel-do-load-languages
;;   'org-babel-load-languages
;;   '((mermaid . t))))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)))



;; ------------------------------
;; org template
;; ------------------------------
(require 'org-tempo)

;; ------------------------------
;; org-download
;; ------------------------------
(use-package org-download
	:ensure t
	:after org
	:bind (:map org-mode-map
		    ("C-M-y" . org-download-clipboard))
	:custom
	;; 所有图片统一放这里
	(org-download-image-dir "./images")
	;; 不按标题建目录
	(org-download-heading-lvl nil))
;;(with-eval-after-load 'org
;;  (define-key org-mode-map (kbd "C-M-y")
;;              #'org-download-clipboard))


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
;;(setq org-startup-with-inline-images t
;;      org-image-actual-width 650
;;      org-image-max-width 900)

;; LaTeX 高清矢量预览
;;(setq org-startup-with-latex-preview t
;;      org-latex-preview-default-scale 1.3
;;      org-latex-preview-dvisvgm-extra-args '("-b" "white"))

;; ------------------------------
;; 导出优化
;; ------------------------------
;; HTML 导出暗黑风格
;;(setq org-html-head-extra
;;      "<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown-dark.min.css'>
;;<style>
;;.markdown-body { max-width: 920px; margin: 0 auto; padding: 2rem; }
;;</style>")
;;(setq org-html-htmlize-output-type 'css)

;; PDF 用 XeLaTeX 编译（中文支持）
;;(setq org-latex-pdf-process
;;      '("xelatex -interaction nonstopmode %f"
;;        "xelatex -interaction nonstopmode %f"))

;; ==============================================
;; 让 Org 模式拥有完整、漂亮的语法高亮
;; ==============================================

;;;; 1. 开启代码块原生语法高亮（必须）
;;(setq org-src-fontify-natively t)
;;
;;;; 2. 开启 Org 模式自身的全部语法高亮（标题、列表、链接、表格等）
;;;;(setq org-highlight-latex-and-related '(native script entities))
;;(setq org-fontify-done-headline t)      ; 已完成任务高亮
;;(setq org-fontify-quote-and-verse-blocks t) ; 引用块高亮
;;(setq org-fontify-whole-heading-line t)  ; 整行标题高亮
;;(setq org-hide-emphasis-markers t)      ; 隐藏 * / = 标记，只显示高亮效果
;;
;;;; 3. 表格、链接、标签高亮增强
;;(setq org-table-fontify-face t)
;;(setq org-link-fontify-middle t)
;;
;;;; 4. 标题层级自动上色（1级~8级标题不同颜色）
;;(custom-set-faces
;; '(org-level-1 ((t (:inherit bold :foreground "#ff6b6b" :height 1.3))))
;; '(org-level-2 ((t (:inherit bold :foreground "#4ecdc4" :height 1.2))))
;; '(org-level-3 ((t (:inherit bold :foreground "#45b7d1" :height 1.1))))
;; '(org-level-4 ((t (:inherit bold :foreground "#96ceb4" :height 1.0))))
;; '(org-level-5 ((t (:inherit bold :foreground "#feca57" :height 1.0))))
;; '(org-level-6 ((t (:inherit bold :foreground "#ff9ff3" :height 1.0))))
;; '(org-level-7 ((t (:inherit bold :foreground "#a29bfe" :height 1.0))))
;; '(org-level-8 ((t (:inherit bold :foreground "#fd79a8" :height 1.0))))
;;
;; ;; 代码块背景高亮
;; '(org-block ((t (:background "#f9f9f9" :inherit fixed-pitch))))
;; '(org-code ((t (:foreground "#d63031" :weight bold))))
;;
;; ;; 链接高亮
;; '(org-link ((t (:foreground "#0984e3" :underline t))))
;;
;; ;; 表格高亮
;; '(org-table ((t (:foreground "#2d3436" :background "#f8f9fa"))))
;;
;; ;; TODO / 关键字高亮
;; '(org-todo ((t (:foreground "#e17055" :weight bold))))
;; '(org-done ((t (:foreground "#00b894" :weight bold))))
;;
;; ;; 标签高亮
;; '(org-tag ((t (:foreground "#555" :background "#eee" :box t :height 0.9))))
;; )
;;
;;;; 5. 自动换行，更像现代编辑器
;;(add-hook 'org-mode-hook (lambda () (visual-line-mode 1)))
;;;; ------------------------------
;; 配置提供
;; ------------------------------
(provide 'init-org)
