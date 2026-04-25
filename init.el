;;(require 'use-package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'load-path "~/.config/emacs/lisp")
(require 'themes)
(require 'lsp-config)
(require 'org-config)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
     "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0"
     "10e330880269244ae45ae9e02fe6f55766da9e15036e7c7f07d7ce228195deb5"
     default))
 '(package-selected-packages
   '(autothemer company dash doom-themes f gruvbox-theme ht lsp-mode lv
		markdown-mode modus-themes s spinner)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
