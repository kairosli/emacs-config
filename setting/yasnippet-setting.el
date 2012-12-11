
;; yasnippet
(add-to-list 'load-path "~/kairosli/.emacs.d/site-lisp/yasnippet-0.8.0/")
(require 'yasnippet) ;; not yasnippet-bundle
(yas--initialize)
(yas/load-directory "~/kairosli/.emacs.d/site-lisp/yasnippet-0.8.0/snippets")
(setq yas/trigger-key (kbd "C-c y"))



(provide 'yasnippet-setting)
