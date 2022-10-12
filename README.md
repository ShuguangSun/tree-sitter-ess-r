[![MELPA](https://melpa.org/packages/tree-sitter-ess-r-badge.svg)](https://melpa.org/#/tree-sitter-ess-r)
[![MELPA Stable](https://stable.melpa.org/packages/tree-sitter-ess-r-badge.svg)](https://stable.melpa.org/#/tree-sitter-ess-r)
[![Build Status](https://github.com/ShuguangSun/tree-sitter-ess-r/workflows/CI/badge.svg)](https://github.com/ShuguangSun/tree-sitter-ess-r/actions)
[![License](http://img.shields.io/:license-gpl3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html)

# tree-sitter-ess-r

R with tree-sitter support.

## Installation

Clone this repository, or install from MELPA. Add the following to your `.emacs`:

``` elisp
(require 'tree-sitter-ess-r)
(add-hook 'ess-r-mode-hook 'tree-sitter-ess-r-mode-activate)
```

or call interactively `M-x tree-sitter-ess-r-using-r-faces`

## Make tree-sitter to support r

Linux

1. git clone https://github.com/r-lib/tree-sitter-r.git
2. gcc ./src/parser.c ./src/scanner.cc -lstdc++ -fPIC -I./ -I./src/ -I./src/tree_sitter --shared -o r.so
3. cp ./r.so /path/to/tree-sitter-langs/langs/bin (/path/to/tree-sitter-langs/ is path of your tree-sitter-langs package)
4. mkdir /path/to/tree-sitter-langs/queries/r
5. cp ./queries/* /path/to/tree-sitter-langs/queries/r


Windows (MINGW64)

1. git clone https://github.com/r-lib/tree-sitter-r.git
2. gcc ./src/parser.c ./src/scanner.cc -lstdc++ -fPIC -I./ -I./src/ -I./src/tree_sitter --shared -o r.dll
3. cp ./r.dll /path/to/tree-sitter-langs/langs/bin (/path/to/tree-sitter-langs/ is path of your tree-sitter-langs package)
4. mkdir /path/to/tree-sitter-langs/queries/r
5. cp ./queries/* /path/to/tree-sitter-langs/queries/r
