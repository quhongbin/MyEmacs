(require 'autoinsert)
(auto-insert-mode 1)

;;set templates files directory
(setq auto-insert-directory "~/.emacs.d/templates/")

;; define file postfix reflect templates
(define-auto-insert '("\\.org\\'" . "org templates") "template.org")
