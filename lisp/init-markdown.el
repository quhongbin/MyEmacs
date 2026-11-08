;;; init-markdown.el --- Markdown configuration with Typora/Obsidian-like rendering -*- lexical-binding: t; -*-

;;; Commentary:
;; 提供类似 Obsidian / Typora 的所见即所得渲染效果：
;; 1. 隐藏 markdown 的各类标记符（如行内代码反引号 `、加粗 **、斜体 *、删除线 ~~、标题 #、超链接括号等）
;; 2. 行内代码背景高亮，如同 Typora / Obsidian 中的独立代码徽章
;; 3. 多行代码块原生语法高亮（Python, C++, Rust, Elisp 等）
;; 4. 标题按照层级阶梯式放大并加粗，无需看 # 号即可识别层级
;; 5. 列表项、引用块、水平分割线等符号进行排版图标化替换
;; 6. 本地及网络图片直接在 buffer 中内联渲染
;; 7. 开启 visual-line-mode，自然视觉自动换行

;;; Code:

(require 'use-package)

;; =============================================================================
;; Markdown 模式主配置
;; =============================================================================

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :init
  ;; 全局默认开启标记符隐藏（隐藏 #、*、**、~~、` 反引号等）
  (setq-default markdown-hide-markup t)
  ;; 开启代码块的原生语法高亮（像对应语言的源码文件一样高亮）
  (setq markdown-fontify-code-blocks-natively t)

  :custom
  ;; 核心：隐藏各类 markdown 标记符号（所见即所得）
  (markdown-hide-markup t)
  ;; 超链接只显示可读文本，隐藏后面的 (url)
  (markdown-hide-urls nil)
  ;; 标题按级别缩放字号（Typora 风格）
  (markdown-header-scaling t)
  ;; 自动加载/显示图片
  (markdown-display-remote-images t)
  (markdown-max-image-size '(800 . 600))
  ;; 列表项标记符号替换为排版圆点
  (markdown-list-item-bullets '("•" "◦" "◆" "◇"))
  ;; 引用块前缀 > 替换为优雅竖线
  (markdown-blockquote-display-char '("▎" "▌" "┃"))
  ;; 支持 LaTeX 行内及行间数学公式渲染
  (markdown-enable-math t)

  :config
  ;; 1. 标题分级美化：根据不同层级放大字体、加粗并继承主题色，替代原始的 # 标记
  (custom-set-faces
   '(markdown-header-face-1 ((t (:inherit (outline-1 bold) :height 1.4))))
   '(markdown-header-face-2 ((t (:inherit (outline-2 bold) :height 1.3))))
   '(markdown-header-face-3 ((t (:inherit (outline-3 bold) :height 1.2))))
   '(markdown-header-face-4 ((t (:inherit (outline-4 bold) :height 1.1))))
   '(markdown-header-face-5 ((t (:inherit (outline-5 bold) :height 1.05))))
   '(markdown-header-face-6 ((t (:inherit (outline-6 bold) :height 1.0))))

   ;; 2. 行内代码美化：隐藏反引号 `` 后，赋予独立的等宽字体和背景底色（类似 Typora/Obsidian 代码徽章）
   '(markdown-inline-code-face
     ((((background dark))
       :inherit fixed-pitch
       :background "#32302f"
       :foreground "#fabd2f")
      (((background light))
       :inherit fixed-pitch
       :background "#ebdbb2"
       :foreground "#b57614")
      (t
       :inherit fixed-pitch
       :background "#3c3836"
       :foreground "#ebdbb2"))))

  ;; 3. 快捷键
  :bind
  (:map markdown-mode-map
        ("C-c C-m" . markdown-toggle-markup-hiding))

  :hook
  ((markdown-mode . (lambda ()
                      ;; 强制启用标记隐藏规范
                      (setq-local markdown-hide-markup t)
                      (add-to-invisibility-spec 'markdown-markup)
                      ;; 开启视觉折行，长段落像 Typora / Obsidian 那样自然排版
                      (visual-line-mode 1)
                      ;; 自动就地显示内联图片
                      (when (display-images-p)
                        (markdown-display-inline-images))))))

(provide 'init-markdown)
;;; init-markdown.el ends here
