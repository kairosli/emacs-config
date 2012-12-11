;; 24.1 自带
(require 'dired-x)
;; 隐藏文件
;; 用来定义你不想看到的文件的扩展名，然后就可以 M-o 过滤掉你不想看到的文件。 再按一次 M-o 就可以看到所 有的文件。
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

;; 排序快捷键
;; s s 按照文件大小排序。
;; s x 按照文件扩展名排序。
;; s t 按照文件访问时间排序。
;; s b 按照文件名称的字母顺序排序。
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


;; 目录在前面
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

;; alt-up快速打开父目录
;; 在 console 下 ALT + &lt;up&gt; 键实际是 ESC &lt;up&gt; 但 是在GUI却是 M-&lt;up&gt; ，
(add-hook 'dired-mode-hook (lambda ()
  (interactive)
  (define-key dired-mode-map (kbd "<M-up>" )
    'dired-up-directory)
  (define-key dired-mode-map (kbd "ESC <up>" ) 'dired-up-directory)))



;; dired-omit-expunge 用来 regexp 过滤文件
(add-hook 'dired-mode-hook (lambda ()
  (interactive)
  (define-key dired-mode-map (kbd "/")  'dired-omit-expunge)))

