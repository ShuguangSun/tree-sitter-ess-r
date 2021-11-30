;;; tree-sitter-ess-r.el --- R with tree-sitter  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Shuguang Sun

;; Author: Shuguang Sun <shuguang79@qq.com>
;; Created: 2021/11/30
;; Version: 0.1
;; URL: https://github.com/ShuguangSun/ess-view-data
;; Package-Requires: ((emacs "26.1") (ess "18.10.1") (tree-sitter "0.12.1"))
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; R with tree-sitter

;;; Code:

(require 'ess-r-mode)
(require 'tree-sitter)
(require 'tree-sitter-hl)
(require 'tree-sitter-langs)
(require 'tree-sitter-query)

(defgroup tree-sitter-ess-r ()
  "R with tree-sitter support."
  :group 'tree-sitter
  :prefix "tree-sitter-ess-r-")

(defface tree-sitter-ess-matrix-face
  '((default :inherit ess-matrix-face))
  "Face for matrixs."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-operator-face
  '((default :inherit ess-operator-face))
  "Face for operators."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-punctuation.bracket-face
  '((default :inherit ess-paren-face))
  "Face for brackets."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-repeat-face
  '((default :inherit ess-keyword-face))
  "Face for repeat keyword."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-assignment-face
  '((default :inherit ess-assignment-face)) ;; ess-assignment-face
  "Face for assignment."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-opspecial-face
  '((default :inherit ess-%op%-face))
  "Face for special `%...%'."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-operatorcomp-face
  '((default :inherit ess-operator-face))
  "Face for REL, OR and AND."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-operatorpipe-face
  '((default :inherit ess-%op%-face))
  "Face for `|>' operator."
  :group 'tree-sitter-ess-r)


(defface tree-sitter-ess-function-face
  '((default :inherit ess-function-call-face))
  "Face for function all."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-conditional-face
  '((default :inherit r-control-flow-keyword-face))
  "Face for control flow keyword."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-keyword.function-face
  '((default :inherit ess-keyword-face))
  "Face for keyword.function."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-float-face
  '((default :inherit ess-numbers-face))
  "Face for numbers."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-number-face
  '((default :inherit ess-numbers-face))
  "Face for numbers."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-modifier-face
  '((default :inherit ess-modifiers-face))
  "Face for modifiers."
  :group 'tree-sitter-ess-r)


(defface tree-sitter-ess-boolean-face
  '((default :inherit ess-constant-face))
  "Face for boolean."
  :group 'tree-sitter-ess-r)


(defface tree-sitter-ess-method-face
  '((default :inherit ess-function-face))
  "Face for method declarations and definitions."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-namespace-face
  '((default :inherit ess-function-face))
  "Face for namespace."
  :group 'tree-sitter-ess-r)


(defface tree-sitter-ess-dollar-face
  '((default :inherit ess-operator-face))
  "Face for dollar."
  :group 'tree-sitter-ess-r)


(defface tree-sitter-ess-error-face
  '((default :inherit font-lock-warning-face))
  "Face for errors."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-comment-face
  '((default :inherit font-lock-comment-face))
  "Face for comments."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-string-face
  '((default :inherit font-lock-string-face))
  "Face for strings."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-doc-face
  '((default :inherit font-lock-doc-face))
  "Face for docs."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-operatorunary-face
  '((default :inherit font-lock-warning-face))
  "Face for some unary operator."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-parameter-face
  '((default :inherit font-lock-builtin-face :weight normal)) ;;  :slant italic
  "Face for parameters."
  :group 'tree-sitter-ess-r)

(defface tree-sitter-ess-varname-face
  '((default :inherit font-lock-variable-name-face)) ;;  :slant italic
  "Face for variable names."
  :group 'tree-sitter-ess-r)

(add-to-list 'tree-sitter-major-mode-language-alist '(ess-r-mode . r))

;; Highlight Python's single-quoted strings as constants.
(tree-sitter-hl-add-patterns 'r
  [;; (arguments "=" @operator)
   ;; (formal_parameters "=" @operator)
   (function_definition "function" @keyword.function)
   (["<-" "<<-" "->"] @assignment)
   ((identifier) @assignment
    ;; (.match? @modifier `,(concat "^(" (mapconcat 'identity ess-R-modifiers "|") ")")))
    (.match? @assignment "^->>$"))
   (equals_assignment "=" @assignment)
   ;; (left_assignment name: (identifier) @varname)
   ;; (equals_assignment name: (identifier) @varname)
   ;; (right_assignment name: (identifier) @varname)
   (dollar "$" @dollar)
   (dollar "@" @dollar)
   (unary operator: ["-" "+" "!" "~"] @operatorunary)
   (binary operator: [
                      "<"
                      ">"
                      "<="
                      ">="
                      "=="
                      "!="
                      "||"
                      "|"
                      "&&"
                      "&"
                      ] @operatorcomp)
   (binary operator: "|>" @operatorpipe)
   (binary operator: [":" "~"] @opspecial)
   (special) @opspecial
   ((identifier) @modifier
    ;; (.match? @modifier `,(concat "^(" (mapconcat 'identity ess-R-modifiers "|") ")")))
    (.match? @modifier "^(library|attach|detach|source|require|setwd|options|par|load|rm|message|warning|.Deprecated|signalCondition|withCallingHandlers)$"))
   ])


(defun tree-sitter-hl-face-from-ess-scope (capture-name)
  "Return the default face used to highlight CAPTURE-NAME."
  ;; TODO: If a scope does not have a corresponding face, check its ancestors.
  ;; (print capture-name)
  (pcase capture-name
    ("operator")
    (_ (intern (format "tree-sitter-ess-%s-face" capture-name)))))



(defun tree-sitter-ess-r-mode-hook-fun ()
  (setq-local tree-sitter-hl-face-mapping-function
              #'tree-sitter-hl-face-from-ess-scope)
  (if (tree-sitter-require 'r)
      (tree-sitter-hl-mode)))

(add-hook 'ess-r-mode-hook 'tree-sitter-ess-r-mode-hook-fun)




(provide 'tree-sitter-ess-r)
;;; tree-sitter-ess-r.el ends here
