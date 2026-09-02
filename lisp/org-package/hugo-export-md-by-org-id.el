;;; hugo-export-md-by-org-id.el --- 自动维护 org-id 索引，让 ox-hugo 能导出 id: 链接 -*- lexical-binding: t; -*-

;; ============================================================================
;; 背景
;;
;;   笔记之间用 org-roam v2 风格的 id 链接互引（例：[[id:20250527T230614][描述]]）。
;;   ox-hugo 导出时会把这种链接转换成 Hugo 的 {{< relref >}} 短代码，但前提是
;;   org-id 能查到「ID -> 文件」的映射表（org-id-locations）。
;;
;;   只在 init-org.el 里静态 setq org-id-extra-files 有两个坑：
;;     1. 值在 Emacs 启动时一次性算死，之后新建的 org 文件不会进列表
;;     2. org-id 只在 (org-id-update-id-locations) 被调用时才读取
;;        org-id-extra-files；从不调用的话，索引只覆盖「碰巧打开过」的文件
;;        和持久化缓存里已有的条目
;;
;;   本模块把 org 文件的打开事件与索引维护关联起来：打开
;;   `hugo-export-md-by-org-id-roots' 下任意 org 文件时，自动把该根目录下
;;   全部 org 文件登记进 org-id-extra-files，并重建一次 ID 索引。
;;   每个根目录每次 Emacs 会话只重建一次，避免每次开文件都全量扫描
;;   （首次扫描 /mnt/d 挂载盘大约需要数秒，属正常）。
;; ============================================================================

(require 'org-id)
(require 'subr-x)                           ; 提供 delete-dups / string-prefix-p

;; ------------------------------
;; 配置项
;; ------------------------------
(defcustom hugo-export-md-by-org-id-roots '("/mnt/d/CPP_LEARNING")
  "需要自动维护 org-id 索引的笔记根目录列表。
打开这些目录（含子目录）下的 org 文件时会触发登记与索引重建。
按需增删；新目录对「下一次打开其中的 org 文件」即生效。"
  :type '(repeat directory)
  :group 'org-id)

;; ------------------------------
;; 内部状态
;; ------------------------------
(defvar hugo-export-md-by-org-id--done-roots nil
  "本次 Emacs 会话已完成索引重建的根目录列表。
用于跳过重复扫描：同一会话内再次打开该目录下的 org 文件时不再重建。")

;; ------------------------------
;; 核心逻辑
;; ------------------------------
(defun hugo-export-md-by-org-id--normalize-extra-files ()
  "把 org-id-extra-files 归一化为列表，返回归一化后的值。
坑点：Emacs 31（org 9.7+）里该变量的默认值是符号
`org-agenda-text-search-extra-files'（间接引用 org-agenda 的搜索文件
列表，org-id 内部用 symbolp 特判）。直接 append 一个符号会报
wrong-type-argument sequencep；且本函数在 org-mode-hook 里被调用，
该错误会中断整个模式初始化（报 File mode specification error，
font-lock 及后续 hook 全部不执行，org 美化失效）。"
  (when (symbolp org-id-extra-files)
    (setq org-id-extra-files
          (copy-sequence
           (if (and (boundp org-id-extra-files)
                    (listp (symbol-value org-id-extra-files)))
               (symbol-value org-id-extra-files)
             nil))))
  org-id-extra-files)

(defun hugo-export-md-by-org-id--setup ()
  "挂在 org-mode-hook 上，打开 org 文件时自动执行。
当前文件位于 `hugo-export-md-by-org-id-roots' 某个根目录之下时：
  1. 把该根目录下全部 org 文件并入 org-id-extra-files（不覆盖已有登记）
  2. 重建一次 org-id 的「ID -> 文件」索引"
  (let ((file (and (buffer-file-name) (expand-file-name (buffer-file-name)))))
    (when file
      (dolist (root hugo-export-md-by-org-id-roots)
        (let ((root (expand-file-name root)))
          (when (and (file-in-directory-p file root)      ; 当前文件在该根目录下
                     (not (member root hugo-export-md-by-org-id--done-roots)))
            (push root hugo-export-md-by-org-id--done-roots)
            ;; 并入而不是覆盖：保留 init.el 等处登记过的条目；delete-dups 去重
            ;; append 前必须先归一化（见 normalize 的注释），否则 Emacs 31 下
            ;; 符号默认值会让 append 报 sequencep 错误并中断 org-mode 初始化
            (setq org-id-extra-files
                  (delete-dups
                   (append (hugo-export-md-by-org-id--normalize-extra-files)
                           (directory-files-recursively root "\\.org\\'"))))
            ;; 重建索引；ignore-errors：个别 org 文件损坏时不阻塞打开文件
            (ignore-errors
              (org-id-update-id-locations))))))))

(defun hugo-export-md-by-org-id-refresh ()
  "手动刷新：重新扫描所有已登记根目录下的 org 文件并重建 ID 索引。
新建了 org 文件、或修改了 :ID: 属性之后，如果不想重开文件，执行这个命令即可。"
  (interactive)
  (setq org-id-extra-files
        (delete-dups
         (apply #'append
                (mapcar (lambda (root)
                          (directory-files-recursively root "\\.org\\'"))
                        hugo-export-md-by-org-id--done-roots))))
  (org-id-update-id-locations)
  (message "org-id 索引已刷新：%d 个根目录，共 %d 个 org 文件"
           (length hugo-export-md-by-org-id--done-roots)
           (length org-id-extra-files)))

;; ------------------------------
;; 关联 org 文件自动执行
;; ------------------------------
(add-hook 'org-mode-hook #'hugo-export-md-by-org-id--setup)

(provide 'hugo-export-md-by-org-id)
