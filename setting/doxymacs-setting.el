
;; doxymacs-C++-function-comment-template函数
;; doxymacs-C++-blank-multiline-comment-template多行注释
;; doxymacs-C++-blank-singleline-comment-template单行注释

;; 命令英文解释中文解释
;; C-c d ? will look up documentation for the symbol under the point.查找当前鼠标点下的符号的文档
;; C-c d r will rescan your Doxygen tags file.重新扫描tags文件
;; C-c d f will insert a Doxygen comment for the next function.为函数插入Doxygen注释
;; C-c d i will insert a Doxygen comment for the current file.为文件插入Doxygen注释
;; C-c d ; will insert a Doxygen comment for the current member.为当前成员插入Doxygen注释
;; C-c d m will insert a blank multiline Doxygen comment.插入多行注释
;; C-c d s will insert a blank singleline Doxygen comment.插入单行注释
;; C-c d @ will insert grouping comments around the current region.插入环绕当前区域的注释

(defconst doxymacs-C++-file-comment-template
  '(
    "/******************************************************************************" > n
    "* Copyright (c) 1998-2012, Tencent Tech. Co., Ltd. All rights reserved."
    "*" > n
    "* " "File name:"
    (if (buffer-file-name)
        (file-name-nondirectory (buffer-file-name))
      "") > n
      "* Author: kairosli" >n
      "*" " Version: 1.0"> n
      "* Date:"  (insert (format-time-string "%Y%m%e %l:%M %a %p"))>n
      "*" " HISTORY     :"> n
      "*" > n
      "*" "******************************************************************************/"> n)
  "Default C++-style template for file documentation.")

(require 'doxymacs)

;;(setq doxymacs-doxygen-style "C++")

(add-hook 'c-mode-common-hook 'doxymacs-mode)
(add-hook 'c++-mode-common-hook 'doxymacs-mode)

