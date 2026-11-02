(use-package ace-window
  :bind ("M-o" . ace-window) ; 建议绑定到顺手的快捷键
  :custom
  ;; 可选：使用键盘主行字母作为标签，比数字更顺手
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))
(provide 'init-ace-windows)
