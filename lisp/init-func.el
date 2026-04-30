;;---------------------------
;;ensure program have been installed in PATH which is system environmental varible
;;---------------------------
(defun init-func-ensure-program (prog &optional pkg)
  "检查 PROG 是否在 PATH 中存在；不存在则用系统包管理器交互式安装 PKG（默认=PROG）。"
  (unless pkg (setq pkg prog))
  (if (executable-find prog)
      (message "✅ %s has existed" prog)
    (progn
      (message "⚠️  %s hasn't existed, ready to install %s" prog pkg)
      (cond
        ;; Debian/Ubuntu/Linux Mint
        ((executable-find "apt")
         (shell-command (format "sudo apt install %s" pkg)))
        ;; Fedora/RHEL/CentOS
        ((executable-find "dnf")
         (shell-command (format "sudo dnf install %s" pkg)))
        ;; Arch/Manjaro
        ((executable-find "pacman")
         (shell-command (format "sudo pacman -S %s" pkg)))
        ;; openSUSE
        ((executable-find "zypper")
         (shell-command (format "sudo zypper install %s" pkg)))
        (t (error "❌ 不支持的包管理器，请手动安装 %s" pkg)))
      ;; 安装后刷新 Emacs 的 PATH 缓存
      (exec-path-from-shell-copy-env "PATH")
      (message "✅ %s 安装完成" pkg))))

;; 示例：确保安装 ripgrep（程序名和包名一样）
;;(init-func-ensure-program "zsh")

;; 示例：确保安装 fzf(程序名=rg，包名=rigrep)
;;(init-func-ensure-program "rg" "rigrep")
(provide 'init-func)
