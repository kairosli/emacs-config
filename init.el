(add-to-list 'load-path "~/kairosli/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/kairosli/.emacs.d/site-lisp/color-theme-6.6.0")
(add-to-list 'load-path "~/kairosli/.emacs.d/site-lisp/doxymacs")
(add-to-list 'load-path "~/kairosli/.emacs.d/setting/")

(defconst EMACS_SETTING "~/kairosli/.emacs.d/setting/")
(defconst EMACS_LISP "~/kairosli/.emacs.d/site-lisp/")

;; dired setting
(load-file (concat EMACS_SETTING "dired-setting.el"))
(load-file (concat EMACS_SETTING "cedet-setting.el"))
(load-file (concat EMACS_SETTING "hippie-exp-setting.el"))
(load-file (concat EMACS_SETTING "sourcepair-setting.el"))
(load-file (concat EMACS_SETTING "doxymacs-setting.el"))
;;(load-file (concat EMACS_SETTING "auto-complete-setting.el"))

(require 'yasnippet-setting)
(require 'auto-complete-setting)
(require 'dev-setting)
(require 'smart-compile-setting)

;; for perl dev->Emacs-PDE
(load "pde-load")

;; highlight current line
(global-hl-line-mode t)

;; insert current date and time
(defun my-insert-date () 
  (interactive) 
  (insert (format-time-string "%Y/%m/%d %H:%M:%S" (current-time)))) 
(global-set-key (kbd "C-c m d") 'my-insert-date) 

;; window back
(winner-mode t)

(require 'xcscope)

;; svn 
(require 'psvn)

;; msf-abbr
;; ensure abbrev mode is always on
(setq-default abbrev-mode t)
;; do not bug me about saving my abbreviations
(setq save-abbrevs nil)
;; load up abbrevs for these modes
(require 'msf-abbrev)
(setq msf-abbrev-root "~/kairosli/.emacs.d/mode-abbrevs")
(msf-abbrev-load)
;; use C-c a to define a new abbrev for this mode
(global-set-key (kbd "C-c a") 'msf-abbrev-define-new-abbrev-this-mode)

;; for securecrt use mouse to move and select
;;(xterm-mouse-mode t)
;;(mouse-sel-mode t)

;; del xxxx_yyyy all[C-M-k]
;;[<](global-set-key [(meta d)] 'kill-sexp)


;;使用M-x desktop-save保存回话,使用M-x desktop-clear清除上次保存的回话
(load "desktop")
(desktop-load-default)
(desktop-read)
(desktop-save-mode t)

;; save info befor exit emacs
;;(add-hook 'kill-emacs-hook (lambda()(desktop-save)))

;;配置session和Desktop
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; disable *GNU Emcas* buffer
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

;; for emacs detect the filecoding and adjust configure
(require 'unicad)
;;(prefer-coding-system 'gb2312) 

(setq-default cursor-type 'bar)

;; 总是不显示菜单,按ctrl+鼠标右键还是能调出菜单
(menu-bar-mode -1)
;;(tool-bar-mode -1)

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     ;;(color-theme-calm-forest)
     ;;(color-theme-oswald)
     (color-theme-renegade)
     ))

;; 支持emacs和外部程序的粘贴
;;(setq x-select-enable-clipboard t)

;;设置kill-ring-max为200
(setq kill-ring-max 200)

;;在模式栏中显示行号列号
(global-linum-mode 1)

;;显示匹配括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;以 y/n代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;关闭自动保存模式
(setq auto-save-mode nil)
;;不生成 #filename# 临时文件
(setq auto-save-default nil)

;;可以递归的使用 minibuffer
(setq enable-recursive-minibuffers t)

;; 在行首 C-k 时，同时删除该行
(setq-default kill-whole-line t)

;; 自动的在文件末增加一新行
(setq require-final-newline t)
;; 当光标在行尾上下移动的时候，始终保持在行尾。
;;(setq track-eol t)

;; 当使用 M-x COMMAND 后，过 1 秒钟显示该 COMMAND 绑定的键
(setq suggest-key-bindings 1)

;; windows (equal to C-x [0-3o]
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-horizontally)
(global-set-key (kbd "M-3") 'split-window-vertically)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-0") 'delete-window)

;; make cursor movement keys under right hand's home-row.
;;(global-set-key (kbd "M-h") 'backward-char) ; was indent-new-comment-line
;;(global-set-key (kbd "M-l") 'forward-char)  ; was downcase-word			
;;(global-set-key (kbd "M-k") 'previous-line) ; was tab-to-tab-stop
;;(global-set-key (kbd "M-j") 'next-line) ; was kill-sentence

;; buffers 
(defalias 'list-buffers 'ibuffer)
;; make buffer switch command show suggestions,better than iswitchhb-mode
(ido-mode 1)
(global-set-key (kbd "C-x k") 'kill-this-buffer); kill current buffer
;; user-defined defun~
;;(global-set-key (kbd "<C-prior>") 'previous-user-buffer) ; Ctrl+PageUp
;;(global-set-key (kbd "<C-next>") 'next-user-buffer) ; Ctrl+PageDown
;;(global-set-key (kbd "<C-S-prior>") 'previous-emacs-buffer) ; Ctrl+Shift+PageUp
;;(global-set-key (kbd "<C-S-next>") 'next-emacs-buffer) ; Ctrl+Shift+PageDown

(setq
 backup-by-copying t ; 自动备份
 backup-directory-alist
 '(("." . "~/kairosli/.emacs.d/backupfiles")) ; 自动备份在目录"~/.saves"下
 delete-old-versions t ; 自动删除旧的备份文件
 kept-new-versions 6 ; 保留最近的6个备份文件
 kept-old-versions 2 ; 保留最早的2个备份文件
 version-control t) ; 多次备份


;;－－－－－－－－－－－－－全局快捷键－－－－－－－－－－－－－－－－
;;;F1：列举我的书签
;;(global-set-key (kbd "<f1>") 'list-bookmarks) 
;;;Ctrl+F1：设置我的书签
;;(global-set-key [C-f1] 'bookmark-set)

;; F2:保存buffer
(global-set-key (kbd "<f1>") 'save-buffer )
;;;Ctrl+F2：保存当前桌面
(global-set-key [C-f1] 'desktop-save)

;;F3:跳转到寄存器保存的位子
(global-set-key (kbd "<f3>") 'jump-to-register)
;;Ctrl+F3:记录当前光标位子到寄存器
(global-set-key [C-f3] 'point-to-register)

;; F4:激活speedbar
(global-set-key [(f4)] 'speedbar-get-focus)

;; F5:最大化当前buffer:
;;(global-set-key [(f5)] 'delete-other-windows)
;; F6:关闭buffer
;;(global-set-key [(f6)] 'kill-buffer-and-window)

;;编译和调试
(setq-default compile-command "make -j6")
(global-set-key [f5] 'smart-compile)
;;下面代码保证emacs在新打开compile窗口的时候只会水平分割窗口
(setq split-height-threshold 0)
(setq split-width-threshold nil)
;; C-x ` is too slow
(global-set-key (kbd "C-x n") 'next-error)
(global-set-key (kbd "C-x p") 'previous-error)


;; F9:格式化代码
(global-set-key [f9] 'c-indent-line-or-region)
;; F10:注释 / 取消注释
(global-set-key [f10] 'comment-or-uncomment-region)

;; F11:激活speedbar
(global-set-key [(f11)] 'copy-to-register)

;;Ctrl+F11:复制区域到寄存器
(global-set-key [C-f11] 'copy-to-register)
;;F11:粘贴寄存器内容
(global-set-key [(f11)] 'insert-register)

;;定义F12键为激活ecb
(global-set-key [f12] 'ecb-activate)
;;定义Ctrl+F12为停止ecb
(global-set-key [C-f12] 'ecb-deactivate)

;;(global-set-key [(control tab)] 'other-window);切换窗口
;;(global-set-key (kbd "C-z") 'undo);撤消
;;(global-set-key (kbd "C-a") 'mark-whole-buffer);全选
(global-set-key [(meta g)] 'goto-line);跳到某行

;;(global-set-key (kbd "C-x b") 'ibuffer);打开ibuffer

;;(global-set-key [(meta left)] 'tabbar-backward);;切换前一个tab
;;(global-set-key [(meta right)]       'tabbar-forward);;切换下一个tab


(if (eq system-uses-terminfo t)
    (progn                              ;; PuTTY hack - needs to be in SCO mode
      (define-key key-translation-map [\e] [\M])
      (define-key input-decode-map "\e[H" [home])
      (define-key input-decode-map "\e[F" [end])
      (define-key input-decode-map "\e[D" [S-left])
      (define-key input-decode-map "\e[C" [S-right])
      (define-key input-decode-map "\e[A" [S-up])
      (define-key input-decode-map "\e[B" [S-down])
      (define-key input-decode-map "\e[C" [S-right])
      (define-key input-decode-map "\e[I" [prior])
      (define-key input-decode-map "\e[G" [next])
      (define-key input-decode-map "\e[M" [f1])
      (define-key input-decode-map "\e[Y" [S-f1])
      (define-key input-decode-map "\e[k" [C-f1])
      (define-key input-decode-map "\e\e[M" [M-f1])
      (define-key input-decode-map "\e[N" [f2])
      (define-key input-decode-map "\e[Z" [S-f2])
      (define-key input-decode-map "\e[l" [C-f2])
      (define-key input-decode-map "\e\e[N" [M-f2])
      (define-key input-decode-map "\e[O" [f3])
      (define-key input-decode-map "\e[a" [S-f3])
      (define-key input-decode-map "\e[m" [C-f3])
      (define-key input-decode-map "\e\e[O" [M-f3])
      (define-key input-decode-map "\e[P" [f4])
      (define-key input-decode-map "\e[b" [S-f4])
      (define-key input-decode-map "\e[n" [C-f4])
      (define-key input-decode-map "\e\e[P" [M-f4])
      (define-key input-decode-map "\e[Q" [f5])
      (define-key input-decode-map "\e[c" [S-f5])
      (define-key input-decode-map "\e[o" [C-f5])
      (define-key input-decode-map "\e\e[Q" [M-f5])
      (define-key input-decode-map "\e[R" [f6])
      (define-key input-decode-map "\e[d" [S-f6])
      (define-key input-decode-map "\e[p" [C-f6])
      (define-key input-decode-map "\e\e[R" [M-f6])
      (define-key input-decode-map "\e[S" [f7])
      (define-key input-decode-map "\e[e" [S-f7])
      (define-key input-decode-map "\e[q" [C-f7])
      (define-key input-decode-map "\e\e[S" [M-f7])
      (define-key input-decode-map "\e[T" [f8])
      (define-key input-decode-map "\e[f" [S-f8])
      (define-key input-decode-map "\e[r" [C-f8])
      (define-key input-decode-map "\e\e[T" [M-f8])
      (define-key input-decode-map "\e[U" [f9])
      (define-key input-decode-map "\e[g" [S-f9])
      (define-key input-decode-map "\e[s" [C-f9])
      (define-key input-decode-map "\e\e[U" [M-f9])
      (define-key input-decode-map "\e[V" [f10])
      (define-key input-decode-map "\e[h" [S-f10])
      (define-key input-decode-map "\e[_" [C-f10])
      (define-key input-decode-map "\e\e[V" [M-f10])
      (define-key input-decode-map "\e[W" [f11])
      (define-key input-decode-map "\e[i" [S-f11])
      (define-key input-decode-map "\e[u" [C-f11])
      (define-key input-decode-map "\e\e[W" [M-f11])
      (define-key input-decode-map "\e[X" [f12])
      (define-key input-decode-map "\e[j" [S-f12])
      (define-key input-decode-map "\e[v" [C-f12])
      (define-key input-decode-map "\e\e[X" [M-f12])))

