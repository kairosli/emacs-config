

(require 'smart-compile)

;; custom compile command, e.g. change makefile path
(add-to-list 'smart-compile-alist
             '("/home/kid/project/foo/.*" . "make -C /home/kid/project/foo"))



(provide 'smart-compile-setting);
