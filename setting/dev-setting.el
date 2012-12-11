;;���������������������������������أ�������������������������������

;;;CC-mode���� http://cc-mode.sourceforge.net/
(require 'cc-mode)

(global-set-key (kbd "C-h s") 'man)
;; ����� man page ʱ��ֱ����ת�� man buffer��
(setq Man-notify-method 'pushy)
;; search all manual and M-n/p switch, k for kill
(setq Man-switches "-a")

(defun code-common-mode ()
  ;; �ƶ�������ͷ�����β
  (local-set-key (kbd "M-a") 'c-beginning-of-defun) 
  (local-set-key (kbd "M-e") 'c-end-of-defun)
  ;; �򿪴����۵�����
  (hs-minor-mode)
  ;; C-M-h ȱʡ��mark-defun��Ч׼ȷ
  (local-set-key (kbd "C-M-h") 'senator-mark-defun)
  ;; C-M-a 
  ;; Move to beginning of current or preceding defun (beginning-of-defun). 
  ;; C-M-e
  ;; Move to end of current or following defun (end-of-defun). 
  ;; C-M-h
  ;; Put region around whole current or following defun (mark-defun). 

  ;; ���ó���Ķ�����
  (c-set-style "stroustrup")
  ;; (c-set-style "linux")
  ;; ��ģʽ������ʾ��ǰ������ں���
  (which-function-mode)
  ;; �Զ�ģʽ���ڴ���ģʽ�µ������{ʱ�����Զ����������õĶ��������
  ;;(c-toggle-auto-state);�˴��ر��Ǿ�������;����Զ����й��ܲ�ϰ��
  ;; ��ģʽ�£�����Backspaceʱ��ɾ�����Ŀո�
  (c-toggle-hungry-state 1)
  ;;�ÿո����tab
  (setq-default indent-tabs-mode nil)
  ;; Alt+Return ���ܲ�ȫ
  (define-key c-mode-base-map (kbd "M-RET") 'semantic-ia-complete-symbol)
  (define-key c-mode-base-map (kbd "RET") 'c-context-line-break)
  ;; Tab��ȫ������
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  ;; �Զ�����,����80��?
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



;;ɾ��ƥ�����ż�����
(defun kill-match-paren (arg)
  (interactive "p")
  (cond ((looking-at "[([{]") (kill-sexp 1) (backward-char))
	((looking-at "[])}]") (forward-char) (backward-kill-sexp 1))
	(t (self-insert-command (or arg 1)))))


;;;ɾ��һ��
(defun zl-delete-line nil
  "delete the whole line"
  (interactive)
  (beginning-of-line);����ƶ�������
  (push-mark);�������
  (beginning-of-line 2);�ƶ�����һ������
  (kill-region (point) (mark)));���ͱ��֮���ɾ��

;;;����һ�л��߶���
;;��C-c C-w ��������, ��"C-u 5 C-c w"���� 5 ��
(defun copy-lines(&optional arg)
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (next-line arg)
    (kill-ring-save (mark) (point))
    )
  )

;;;C-x c ��������, ��"C-u 5 C-x c"���� 5 ��
(global-set-key (kbd "C-x c") 'copy-lines);;;����һ�л��߶���
(global-set-key (kbd "C-x d") 'zl-delete-line);;ɾ��һ��
(global-set-key (kbd "C-x %") 'kill-match-paren);;ɾ��ƥ�����ż�����

(provide 'dev-setting)
