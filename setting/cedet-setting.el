;; http://blog.163.com/vic_kk/blog/static/494705242010726297405/
;; http://emacser.com/built-in-cedet.htm

(require 'cedet)

;; Semantic DataBase存储位置
(setq semanticdb-default-save-directory
      (expand-file-name "~/kairosli/.emacs.d/semanticdb"))
      
;;;;  Helper tools.
(custom-set-variables
 '(semantic-default-submodes (quote (global-semantic-decoration-mode ;;global-semantic-idle-completions-mode
                                     global-semantic-idle-scheduler-mode global-semanticdb-minor-mode
                                     global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
 '(semantic-idle-scheduler-idle-time 3))

(semantic-mode 1)

;; turn on cscope semanticdb backend
;;(require 'semanticdb-cscope)
;;(semanticdb-enable-cscope-databases)


;; smart complitions
(require 'semantic/ia)
;;(setq-mode-local c-mode semanticdb-find-default-throttle
;;                 '(project unloaded system recursive))
;;(setq-mode-local c++-mode semanticdb-find-default-throttle
;;                 '(project unloaded system recursive))

;;  semantic-analyze-tag-references
(require 'semantic/analyze/refs)                 
                 
;;;; Include settings
(require 'semantic/bovine/gcc)
(require 'semantic/bovine/c)

(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "."
        "../.." "../../include" "../../inc" "../../common" "../../public"))

(setq cedet-sys-include-dirs (list
                              "/usr/include"
                              "/usr/include/c++/4.1.2"
                              "/usr/include/c++/4.1.2/x86_64-suse-linux/bits/"
                              "/usr/include/sys"
                              "/usr/local/taf/include/util"
                              "/usr/local/taf/include/servant"
                              "/usr/local/taf/include/patch"
                              "/usr/local/taf/include/parse"
                              "/usr/local/taf/include/notify"
                              "/usr/local/taf/include/nodeF"
                              "/usr/local/taf/include/log"
                              "/usr/local/taf/include/jmem"
                              "/usr/local/taf/include/jce"
                              "/usr/local/taf/include/hessian"
                              "/usr/local/taf/include/config"
                              "/usr/local/taf/include"))
(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

;; (semantic-add-system-include "/usr/include" 'c++-mode)
;; (semantic-add-system-include "/usr/include" 'c-mode)
;; (semantic-add-system-include "/usr/local/include" 'c++-mode)
;; (semantic-add-system-include "/usr/local/include" 'c-mode)
;; (semantic-add-system-include "/usr/local/taf/include" 'c++-mode)
;; (semantic-add-system-include "/usr/local/taf/include" 'c-mode)

(setq semantic-c-dependency-system-include-path "/usr/include/")                 


;;;; TAGS Menu
;;(defun my-semantic-hook ()
;;  (imenu-add-to-menubar "TAGS"))        

;;(add-hook 'semantic-init-hooks 'my-semantic-hook)

;; 使用 gnu global 的TAGS。
;;(require 'semantic/db-global)
;;(semanticdb-enable-gnu-global-databases 'c-mode)
;;(semanticdb-enable-gnu-global-databases 'c++-mode)

;; for mru bookmark
(defadvice push-mark (around semantic-mru-bookmark activate)
  "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
	If `semantic-mru-bookmark-mode' is active, also push a tag onto
	the mru bookmark stack."
  (semantic-mrub-push semantic-mru-bookmark-ring
                      (point)
                      'mark)
  ad-do-it)

;;;; C-mode-hooks .
(defun yyc/c-mode-keys ()
  "description"
  ;; Semantic functions.
  (semantic-default-c-setup)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
  (local-set-key "\C-cR" 'semantic-symref)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cp" 'semantic-ia-show-summary)
  (local-set-key "\C-cl" 'semantic-ia-show-doc)
  (local-set-key "\C-cr" 'semantic-symref-symbol)
  (local-set-key "\C-c/" 'semantic-ia-complete-symbol)
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert)
  ;; Indent or complete
  (local-set-key  [(tab)] 'indent-or-complete)
  )
(add-hook 'c-mode-common-hook 'yyc/c-mode-keys)


;; senator
(require 'semantic/senator)
