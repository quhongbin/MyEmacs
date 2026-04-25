;; ==============================================
;; Org 渲染 & 美化 独立配置（优化版）
;; 依赖：org-modern, emacs 内置 org
;; ==============================================

;; ------------------------------
;; 基础界面优化（不依赖外部包）
;; ------------------------------ 


;; 符号美化（内置 prettify-symbols-mode）
(add-hook 'org-mode-hook #'prettify-symbols-mode)
(add-hook 'org-mode-hook
	  (lambda()
	    (setq-local prettify-symbols-alist
			'(("#+begin_src" . ">")
			  ("#+end_src" . ">")))
	    (prettify-symbols-mode 1)))

;; ------------------------------
;; org template
;; ------------------------------
(require 'org-tempo)

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

;; 编辑代码时开启行号和当前行高亮

;; 语言模式映射

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
(provide 'org-config)
