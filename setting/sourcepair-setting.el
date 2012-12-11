;; cpp源文件与头文件之间切换

; source pair

(load-file (concat EMACS_LISP "sourcepair.el"))
(define-key global-map "\C-xz" 'sourcepair-load)

(setq sourcepair-source-path '( "." "../*" "../src" ))

(setq sourcepair-header-path '( "." "include" "../include" "../*" "../inc"))