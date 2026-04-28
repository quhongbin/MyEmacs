(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
;;(setq package-archives '(("gnu"   . "http://1.15.88.122/gnu/")
;;                          ("melpa" . "http://1.15.88.122/melpa/")
;;			   ("nongnu" . "http://1.15.88.122/nongnu")))
;;
;;(setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                         ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;                         ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;;
(package-initialize)
(setq eaf-python-command "/usr/bin/python3")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
(require 'eaf)
(require 'eaf-mind-elixir)
(require 'eaf-music-player)
(require 'eaf-rss-reader)
(require 'eaf-terminal)
(require 'eaf-vue-demo)
(require 'eaf-vue-tailwindcss)
(require 'eaf-mindmap)
(require 'eaf-image-viewer)
;;(require 'eaf-video-editor)
(require 'eaf-video-player)
(require 'eaf-org-previewer)
(require 'eaf-markdown-previewer)
(require 'eaf-jupyter)
(require 'eaf-markmap)
(require 'eaf-map)
(require 'eaf-pdf-viewer)
(require 'eaf-git)
(require 'eaf-airshare)
(require 'eaf-pyqterminal)
(require 'eaf-system-monitor)
(require 'eaf-file-manager)
(require 'eaf-browser)
(require 'eaf-file-sender)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'editor)
(require 'themes)
(require 'lsp-config)
(require 'org-config)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a"
     "d12b1d9b0498280f60e5ec92e5ecec4b5db5370d05e787bc7cc49eae6fb07bc0"
     "b754d3a03c34cfba9ad7991380d26984ebd0761925773530e24d8dd8b6894738"
     "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d"
     "4d5d11bfef87416d85673947e3ca3d3d5d985ad57b02a7bb2e32beaf785a100e"
     "3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b"
     "d481904809c509641a1a1f1b1eb80b94c58c210145effc2631c1a7f2e4a2fdf4"
     "9b9d7a851a8e26f294e778e02c8df25c8a3b15170e6f9fd6965ac5f2544ef2a9"
     "5c7720c63b729140ed88cf35413f36c728ab7c70f8cd8422d9ee1cedeb618de5"
     "b7a09eb77a1e9b98cafba8ef1bd58871f91958538f6671b22976ea38c2580755"
     "f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
     "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0"
     "10e330880269244ae45ae9e02fe6f55766da9e15036e7c7f07d7ce228195deb5"
     default))
 '(package-selected-packages '(company doom-themes htmlize lsp-mode terminal-here vterm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
