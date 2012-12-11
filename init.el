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


;;ʹ��M-x desktop-save����ػ�,ʹ��M-x desktop-clear����ϴα���Ļػ�
(load "desktop")
(desktop-load-default)
(desktop-read)
(desktop-save-mode t)

;; save info befor exit emacs
;;(add-hook 'kill-emacs-hook (lambda()(desktop-save)))

;;����session��Desktop
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; disable *GNU Emcas* buffer
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

;; for emacs detect the filecoding and adjust configure
(require 'unicad)
;;(prefer-coding-system 'gb2312) 

(setq-default cursor-type 'bar)

;; ���ǲ���ʾ�˵�,��ctrl+����Ҽ������ܵ����˵�
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

;; ֧��emacs���ⲿ�����ճ��
;;(setq x-select-enable-clipboard t)

;;����kill-ring-maxΪ200
(setq kill-ring-max 200)

;;��ģʽ������ʾ�к��к�
(global-linum-mode 1)

;;��ʾƥ������
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;�� y/n���� yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;�ر��Զ�����ģʽ
(setq auto-save-mode nil)
;;������ #filename# ��ʱ�ļ�
(setq auto-save-default nil)

;;���Եݹ��ʹ�� minibuffer
(setq enable-recursive-minibuffers t)

;; ������ C-k ʱ��ͬʱɾ������
(setq-default kill-whole-line t)

;; �Զ������ļ�ĩ����һ����
(setq require-final-newline t)
;; ���������β�����ƶ���ʱ��ʼ�ձ�������β��
;;(setq track-eol t)

;; ��ʹ�� M-x COMMAND �󣬹� 1 ������ʾ�� COMMAND �󶨵ļ�
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
 backup-by-copying t ; �Զ�����
 backup-directory-alist
 '(("." . "~/kairosli/.emacs.d/backupfiles")) ; �Զ�������Ŀ¼"~/.saves"��
 delete-old-versions t ; �Զ�ɾ���ɵı����ļ�
 kept-new-versions 6 ; ���������6�������ļ�
 kept-old-versions 2 ; ���������2�������ļ�
 version-control t) ; ��α���


;;��������������������������ȫ�ֿ�ݼ���������������������������������
;;;F1���о��ҵ���ǩ
;;(global-set-key (kbd "<f1>") 'list-bookmarks) 
;;;Ctrl+F1�������ҵ���ǩ
;;(global-set-key [C-f1] 'bookmark-set)

;; F2:����buffer
(global-set-key (kbd "<f1>") 'save-buffer )
;;;Ctrl+F2�����浱ǰ����
(global-set-key [C-f1] 'desktop-save)

;;F3:��ת���Ĵ��������λ��
(global-set-key (kbd "<f3>") 'jump-to-register)
;;Ctrl+F3:��¼��ǰ���λ�ӵ��Ĵ���
(global-set-key [C-f3] 'point-to-register)

;; F4:����speedbar
(global-set-key [(f4)] 'speedbar-get-focus)

;; F5:��󻯵�ǰbuffer:
;;(global-set-key [(f5)] 'delete-other-windows)
;; F6:�ر�buffer
;;(global-set-key [(f6)] 'kill-buffer-and-window)

;;����͵���
(setq-default compile-command "make -j6")
(global-set-key [f5] 'smart-compile)
;;������뱣֤emacs���´�compile���ڵ�ʱ��ֻ��ˮƽ�ָ��
(setq split-height-threshold 0)
(setq split-width-threshold nil)
;; C-x ` is too slow
(global-set-key (kbd "C-x n") 'next-error)
(global-set-key (kbd "C-x p") 'previous-error)


;; F9:��ʽ������
(global-set-key [f9] 'c-indent-line-or-region)
;; F10:ע�� / ȡ��ע��
(global-set-key [f10] 'comment-or-uncomment-region)

;; F11:����speedbar
(global-set-key [(f11)] 'copy-to-register)

;;Ctrl+F11:�������򵽼Ĵ���
(global-set-key [C-f11] 'copy-to-register)
;;F11:ճ���Ĵ�������
(global-set-key [(f11)] 'insert-register)

;;����F12��Ϊ����ecb
(global-set-key [f12] 'ecb-activate)
;;����Ctrl+F12Ϊֹͣecb
(global-set-key [C-f12] 'ecb-deactivate)

;;(global-set-key [(control tab)] 'other-window);�л�����
;;(global-set-key (kbd "C-z") 'undo);����
;;(global-set-key (kbd "C-a") 'mark-whole-buffer);ȫѡ
(global-set-key [(meta g)] 'goto-line);����ĳ��

;;(global-set-key (kbd "C-x b") 'ibuffer);��ibuffer

;;(global-set-key [(meta left)] 'tabbar-backward);;�л�ǰһ��tab
;;(global-set-key [(meta right)]       'tabbar-forward);;�л���һ��tab


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

