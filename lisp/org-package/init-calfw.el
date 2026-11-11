;;; init-calfw.el --- Calfw and Google Calendar Integration -*- lexical-binding: t; -*-

;; =============================================================================
;; 1. 加载本地私密密钥配置（密钥存放于本地 calfw-secrets.el）
;; =============================================================================
(let ((secrets-file (expand-file-name "calfw-secrets.el"
                                     (file-name-directory (or load-file-name buffer-file-name (buffer-file-name))))))
  (if (file-exists-p secrets-file)
      (load-file secrets-file)
    (message "[init-calfw] 提示: %s 未找到，请根据模板配置密钥与邮箱" secrets-file)))

;; =============================================================================
;; 2. 全局 Agenda 与 Google Calendar 基础路径配置
;; =============================================================================

(defvar my/global-agenda-file (expand-file-name "~/org/agenda.org")
  "全局日常任务与规划 Org 文件路径。")

(defvar my/global-gcal-file (expand-file-name "~/org/google-canlendar.org")
  "全局 Google Calendar 同步文件路径。")

;; 确保 ~/org 目录及默认文件存在
(let ((org-dir (expand-file-name "~/org/")))
  (unless (file-directory-p org-dir)
    (make-directory org-dir t))
  (unless (file-exists-p my/global-agenda-file)
    (with-temp-file my/global-agenda-file
      (insert "#+TITLE: Agenda\n\n")))
  (unless (file-exists-p my/global-gcal-file)
    (with-temp-file my/global-gcal-file
      (insert "#+TITLE: Google Calendar\n\n"))))

;; 设置全局 org-agenda-files 列表
(setq org-agenda-files (list my/global-agenda-file my/global-gcal-file))

;; 确保 org-gcal-fetch-file-alist 绑定全局 Google Calendar 文件
(let ((user-email (or (bound-and-true-p org-gcal-user-email)
                      (caar (bound-and-true-p org-gcal-fetch-file-alist)))))
  (when user-email
    (setq org-gcal-fetch-file-alist `((,user-email . ,my/global-gcal-file)))))

;; =============================================================================
;; 3. 基础 calfw 日历框架
;; =============================================================================
(use-package calfw
  :ensure t
  :demand t
  :config
  ;; 设置边框字符
  (setq cfw:fchar-junction ?+
        cfw:fchar-vertical-line ?|
        cfw:fchar-horizontal-line ?-
        cfw:fchar-left-junction ?>
        cfw:fchar-right-junction ?<
        cfw:fchar-top-junction ?^
        cfw:fchar-top-left-corner ?/
        cfw:fchar-top-right-corner ?\\)

  ;; 兼容性修复：防止因未指定背景/前景颜色导致颜色合成报错
  (defun my/calfw-composite-color (clr1 alpha clr2)
    (let* ((rgb1 (or (color-name-to-rgb clr1) '(0 0 0)))
           (rgb2 (or (and (stringp clr2) (color-name-to-rgb clr2))
                     (if (eq (frame-parameter nil 'background-mode) 'dark)
                         '(1 1 1)
                       '(0 0 0))))
           (result-rgb (cl-mapcar (lambda (c1 c2)
                                    (+ (* alpha c1)
                                       (* (- 1 alpha) c2)))
                                  rgb1 rgb2)))
      (apply #'color-rgb-to-hex (append result-rgb '(2)))))
  (advice-add 'calfw-composite-color :override #'my/calfw-composite-color))

;; =============================================================================
;; 4. calfw-org：从 Org-mode 生成日历视图
;; =============================================================================
(use-package calfw-org
  :ensure t
  :demand t
  :after (calfw org)
  :config
  ;; 设置每周从周一开始（0 为周日，1 为周一）
  (setq calendar-week-start-day 1))

;; =============================================================================
;; 5. calfw-ical：支持加载 Google Calendar 的私有 iCal (ICS) 链接（可选）
;; =============================================================================
(use-package calfw-ical
  :ensure t
  :defer t)

;; =============================================================================
;; 6. org-gcal：Google Calendar 双向同步
;; =============================================================================
(use-package org-gcal
  :ensure t
  :after org
  :commands (org-gcal-fetch org-gcal-sync org-gcal-post-at-point)
  :config
  ;; 启用对称加密密码缓存，防止频繁提示输入解密密码
  (setq plstore-cache-passphrase-for-symmetric-encryption t)
  (setq epa-file-cache-passphrase-for-symmetric-encryption t)
  (setq epa-pinentry-mode 'loopback))

;; 同步/拉取完成后自动将 Org 缓冲区保存至磁盘
(defun my/org-gcal-save-buffers (&rest _)
  "确保 org-gcal-fetch-file-alist 中的目标文件在同步或抓取后自动写盘保存。"
  (dolist (item (bound-and-true-p org-gcal-fetch-file-alist))
    (when-let* ((file (cdr item))
                (buf (find-buffer-visiting file)))
      (with-current-buffer buf
        (when (buffer-modified-p)
          (save-buffer))))))

(with-eval-after-load 'org-gcal
  (advice-add 'org-gcal-sync :after #'my/org-gcal-save-buffers)
  (advice-add 'org-gcal-fetch :after #'my/org-gcal-save-buffers))

;; =============================================================================
;; 7. calfw-gcal 包配置（保留备用）
;; =============================================================================
(use-package calfw-gcal
  :ensure t
  :after calfw
  :config
  (setq cfw:gcal-py-alias "python3"))

;; =============================================================================
;; 8. 综合日历开启命令：整合 Org-mode 与 Google Calendar
;; =============================================================================
(defun my/open-calendar ()
  "打开整合了全局 Agenda 与 Google Calendar 的 Calfw 日历视图。"
  (interactive)
  (require 'calfw)
  (require 'calfw-org)
  (let ((sources nil))
    ;; 1. 本地全局任务源（绿色）
    (when (file-exists-p my/global-agenda-file)
      (push (calfw-org-create-source (list my/global-agenda-file) "Agenda" "ForestGreen")
            sources))
    ;; 2. Google 日历源（宝蓝色）
    (when (file-exists-p my/global-gcal-file)
      (push (calfw-org-create-source (list my/global-gcal-file) "Google Calendar" "RoyalBlue")
            sources))
    ;; 3. 若配置了 iCal 私密地址，同时作为只读源加载（印第安红）
    (when (and (boundp 'my/gcal-ical-url)
               (stringp my/gcal-ical-url)
               (not (string-empty-p my/gcal-ical-url)))
      (require 'calfw-ical)
      (push (calfw-ical-create-source my/gcal-ical-url "Google iCal" "IndianRed") sources))
    (calfw-open-calendar-buffer
     :contents-sources (nreverse sources)
     :view 'month)))

;; =============================================================================
;; 9. 批量推送当前 Org 文件中所有未同步的日程到 Google Calendar
;; =============================================================================
(defun my/org-gcal-post-buffer (&optional calendar-id)
  "将当前 Org 文件中所有尚未推送到 Google Calendar 的日程条目批量推送上去。"
  (interactive)
  (unless (derived-mode-p 'org-mode)
    (user-error "请在 Org 格式文件（例如 agenda.org）中运行此命令"))
  (require 'org-gcal)
  (unless (and (boundp 'org-gcal-fetch-file-alist) org-gcal-fetch-file-alist)
    (user-error "未配置 org-gcal-fetch-file-alist，请检查 calfw-secrets.el"))
  (let* ((target-cal-id
          (or calendar-id
              (if (= (length org-gcal-fetch-file-alist) 1)
                  (caar org-gcal-fetch-file-alist)
                (replace-regexp-in-string
                 ".*(\\(.*?\\))$" "\\1"
                 (completing-read "选择要推送的目标 Google Calendar: "
                                  (mapcar (lambda (x) (format "%s (%s)" (cdr x) (car x)))
                                          org-gcal-fetch-file-alist))))))
         (count 0))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward org-heading-regexp nil t)
        (let ((has-gcal-id (org-entry-get (point) org-gcal-entry-id-property))
              (has-timestamp (or (org-entry-get (point) "SCHEDULED")
                                 (org-entry-get (point) "DEADLINE")
                                 (org-entry-get (point) "TIMESTAMP"))))
          ;; 仅对包含时间戳且尚未被 Google Calendar 纳管的条目推送
          (when (and has-timestamp (not has-gcal-id))
            (org-entry-put (point) org-gcal-calendar-id-property target-cal-id)
            (org-gcal-post-at-point)
            (setq count (1+ count))))))
    (message "成功将 %d 个日程条目推送到 Google Calendar (%s)" count target-cal-id)))

(provide 'init-calfw)
;;; init-calfw.el ends here
