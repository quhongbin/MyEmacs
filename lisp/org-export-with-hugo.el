(defun my/export-cpp-learning-to-hugo ()
(setq org-hugo-base-dir "~/Obsidian/hugo_blog/") ; Hugo 根目录
  "将 CPP_LEARNING 下所有 Org 文件导出到 Hugo，保留目录结构并生成分类和标签，忽略非 Org 文件."
  (interactive)
  (let ((org-directory "~/Obsidian/CPP_LEARNING/"))
    (dolist (file (directory-files-recursively org-directory "\\.org$")) ; 只匹配 org 文件
      (with-current-buffer (find-file-noselect file)
        ;; 计算相对路径，用于 section
        (let* ((relative-dir (file-relative-name
                              (file-name-directory file)
                              org-directory))
               (section-name (replace-regexp-in-string "/$" "" relative-dir))
               ;; 用子目录名生成分类和标签
               (categories (split-string section-name "/"))
               (tags categories))
          ;; 设置 Hugo section
          (setq org-hugo-section section-name)
          ;; 设置 Hugo categories & tags
          (setq org-hugo-categories categories)
          (setq org-hugo-tags tags))
        ;; 导出到 Hugo
        (org-hugo-export-to-md)))))

;; -----------------------------
;; ox-hugo 单文件交互式导出
;; -----------------------------
(defun my/export-current-org-to-hugo ()
  "交互式导出当前 Org 文件到 Hugo。
提示选择 Hugo section（content 子目录），保持原文件名作为 slug。"
  (interactive)
  (require 'ox-hugo)
  ;; 确保使用 Hugo 根目录
  (setq org-hugo-base-dir "~/Obsidian/hugo_blog/")
  ;; 提示用户输入 section（content 子目录）
  (let ((section (read-string "Enter Hugo section (content subdir): "))
        (slug (file-name-base (buffer-file-name)))) ; 使用原文件名作为 slug
    (setq org-hugo-section section)
    (setq org-hugo-slug slug)
    ;; 导出当前文件
    (org-hugo-export-wim-to-md)))

;; 快捷键调用
(global-set-key (kbd "C-c h s") 'my/export-current-org-to-hugo)
