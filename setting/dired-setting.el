;; 24.1 �Դ�
(require 'dired-x)
;; �����ļ�
;; ���������㲻�뿴�����ļ�����չ����Ȼ��Ϳ��� M-o ���˵��㲻�뿴�����ļ��� �ٰ�һ�� M-o �Ϳ��Կ����� �е��ļ���
(setq dired-omit-files
      (rx (or (seq bol (? ".") "#")         ;; emacs autosave files
              (seq bol "." (not (any "."))) ;; dot-files
              (seq "~" eol)                 ;; backup-files
              (seq bol "CVS" eol)           ;; CVS dirs
              (seq bol ".svn" eol)          ;; svn dirs
              (seq ".o" eol)    	        ;; object files
              (seq ".d" eol)    	        ;; dependency files
              (seq bol "tags" eol)    	    ;; tag file              
              (seq bol "cscope")    	    ;; cscope
              )))

(setq dired-omit-extensions
      (append dired-latex-unclean-extensions
              dired-bibtex-unclean-extensions
              dired-texinfo-unclean-extensions))

(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))


;; C-x C-d open the directory of current buffer
(global-set-key (kbd "C-x C-d")
                (lambda ()
                  (interactive)
                  (if (buffer-file-name)
                      (dired default-directory))))

;; �����ݼ�
;; s s �����ļ���С����
;; s x �����ļ���չ������
;; s t �����ļ�����ʱ������
;; s b �����ļ����Ƶ���ĸ˳������
(add-hook 'dired-mode-hook (lambda ()
  (interactive)
  (make-local-variable  'dired-sort-map)
  (setq dired-sort-map (make-sparse-keymap))
  (define-key dired-mode-map "s" dired-sort-map)
  (define-key dired-sort-map "s"
              '(lambda () "sort by Size"
                (interactive) (dired-sort-other (concat dired-listing-switches "S"))))
  (define-key dired-sort-map "x"
              '(lambda () "sort by eXtension"
                 (interactive) (dired-sort-other (concat dired-listing-switches "X"))))
  (define-key dired-sort-map "t"
              '(lambda () "sort by Time"
                 (interactive) (dired-sort-other (concat dired-listing-switches "t"))))
  (define-key dired-sort-map "n"
              '(lambda () "sort by Name"
                 (interactive) (dired-sort-other (concat dired-listing-switches ""))))))


;; Ŀ¼��ǰ��
(defun sof/dired-sort ()
  "Dired sort hook to list directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil))
(add-hook 'dired-after-readin-hook 'sof/dired-sort)

;; alt-up���ٴ򿪸�Ŀ¼
;; �� console �� ALT + &lt;up&gt; ��ʵ���� ESC &lt;up&gt; �� ����GUIȴ�� M-&lt;up&gt; ��
(add-hook 'dired-mode-hook (lambda ()
  (interactive)
  (define-key dired-mode-map (kbd "<M-up>" )
    'dired-up-directory)
  (define-key dired-mode-map (kbd "ESC <up>" ) 'dired-up-directory)))



;; dired-omit-expunge ���� regexp �����ļ�
(add-hook 'dired-mode-hook (lambda ()
  (interactive)
  (define-key dired-mode-map (kbd "/")  'dired-omit-expunge)))

