;; -*- lexical-binding: t; -*-
(use-package ace-window
  :bind ("M-o" . ace-window) ; 建议绑定到顺手的快捷键
  :custom
  ;; 可选：使用键盘主行字母作为标签，比数字更顺手
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq 'aw-ignore-on 0))

;; ace-window plugin have fillter feature,
;; this function aim to remove treemacs from ignored buffers
(with-eval-after-load 'ace-window
  (setq aw-ignored-buffers (delq 'treemacs-mode aw-ignored-buffers)))

(provide 'init-ace-windows)
