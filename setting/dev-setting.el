;;－－－－－－－－－－－－－－编程相关－－－－－－－－－－－－－－－－

;;;CC-mode配置 http://cc-mode.sourceforge.net/
(require 'cc-mode)

(global-set-key (kbd "C-h s") 'man)
;; 当浏览 man page 时，直接跳转到 man buffer。
(setq Man-notify-method 'pushy)
;; search all manual and M-n/p switch, k for kill
(setq Man-switches "-a")

(defun code-common-mode ()
  ;; 移动到函数头部与结尾
  (local-set-key (kbd "M-a") 'c-beginning-of-defun) 
  (local-set-key (kbd "M-e") 'c-end-of-defun)
  ;; 打开代码折叠功能
  (hs-minor-mode)
  ;; C-M-h 缺省的mark-defun有效准确
  (local-set-key (kbd "C-M-h") 'senator-mark-defun)
  ;; C-M-a 
  ;; Move to beginning of current or preceding defun (beginning-of-defun). 
  ;; C-M-e
  ;; Move to end of current or following defun (end-of-defun). 
  ;; C-M-h
  ;; Put region around whole current or following defun (mark-defun). 

  ;; 设置程序的对齐风格
  (c-set-style "stroustrup")
  ;; (c-set-style "linux")
  ;; 在模式栏中显示当前光标所在函数
  (which-function-mode)
  ;; 自动模式，在此种模式下当你键入{时，会自动根据你设置的对齐风格对齐
  ;;(c-toggle-auto-state);此处关闭是觉得输入;后的自动换行功能不习惯
  ;; 此模式下，当按Backspace时会删除最多的空格
  (c-toggle-hungry-state 1)
  ;;用空格代替tab
  (setq-default indent-tabs-mode nil)
  ;; Alt+Return 智能补全
  (define-key c-mode-base-map (kbd "M-RET") 'semantic-ia-complete-symbol)
  (define-key c-mode-base-map (kbd "RET") 'c-context-line-break)
  ;; Tab补全或缩进
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  ;; 自动换行,超过80字?
  ;;(auto-fill-mode)		
  )

;; insert () {} '' "" pair easily
(electric-pair-mode t)

;; (defun my-c-mode-auto-pair ()
;;   (interactive)
;;   (make-local-variable 'skeleton-pair-alist)
;;   (setq skeleton-pair-alist  '(
;; 			       (?{ \n > _ \n ?} >)))
;;   (setq skeleton-pair t)
;;   (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
;;   )

;; (add-hook 'c-mode-hook 'my-c-mode-auto-pair)
;; (add-hook 'c++-mode-hook 'my-c-mode-auto-pair)

(add-hook 'c-mode-hook	'code-common-mode)

(add-hook 'c++-mode-hook 'code-common-mode)

(add-to-list 'auto-mode-alist '("\\.jce$" . c++-mode))
;;(add-to-list 'auto-mode-alist '("\\.ipp$" . c++-mode))
;(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))



;;删除匹配括号间内容
(defun kill-match-paren (arg)
  (interactive "p")
  (cond ((looking-at "[([{]") (kill-sexp 1) (backward-char))
	((looking-at "[])}]") (forward-char) (backward-kill-sexp 1))
	(t (self-insert-command (or arg 1)))))


;;;删除一行
(defun zl-delete-line nil
  "delete the whole line"
  (interactive)
  (beginning-of-line);光标移动到行首
  (push-mark);做个标记
  (beginning-of-line 2);移动到下一行行首
  (kill-region (point) (mark)));光标和标记之间的删掉

;;;复制一行或者多行
;;；C-c C-w 复制整行, 而"C-u 5 C-c w"复制 5 行
(defun copy-lines(&optional arg)
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (next-line arg)
    (kill-ring-save (mark) (point))
    )
  )

;;;C-x c 复制整行, 而"C-u 5 C-x c"复制 5 行
(global-set-key (kbd "C-x c") 'copy-lines);;;复制一行或者多行
(global-set-key (kbd "C-x d") 'zl-delete-line);;删除一行
(global-set-key (kbd "C-x %") 'kill-match-paren);;删除匹配括号间内容

(provide 'dev-setting)
