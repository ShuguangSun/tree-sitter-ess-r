[![MELPA](https://melpa.org/packages/qpdf-badge.svg)](https://melpa.org/#/qpdf)
[![MELPA Stable](https://stable.melpa.org/packages/qpdf-badge.svg)](https://stable.melpa.org/#/qpdf)
[![Build Status](https://github.com/ShuguangSun/qpdf.el/workflows/CI/badge.svg)](https://github.com/ShuguangSun/qpdf.el/actions)
[![License](http://img.shields.io/:license-gpl3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html)

# tree-sitter-ess-r

R with tree-sitter support.

## Installation

Clone this repository, or install from MELPA. Add the following to your `.emacs`:

``` elisp
(require 'tree-sitter-ess-r)
```

## Make tree-sitter to support r

Linux

1. git clone https://github.com/r-lib/tree-sitter-r.git
2. gcc ./src/parser.c -fPIC -I./ --shared -o r.so
3. cp ./r.so /path/to/tree-sitter-langs/langs/bin (/path/to/tree-sitter-langs/ is path of your tree-sitter-langs package)
4. mkdir /path/to/tree-sitter-langs/queries/r
5. cp ./queries/* /path/to/tree-sitter-langs/queries/r


windows (MINGW64)

1. git clone https://github.com/r-lib/tree-sitter-r.git
2. gcc ./src/parser.c -fPIC -I./ -I./src/ --shared -o r.dll
3. cp ./r.dll /path/to/tree-sitter-langs/langs/bin (/path/to/tree-sitter-langs/ is path of your tree-sitter-langs package)
4. mkdir /path/to/tree-sitter-langs/queries/r
5. cp ./queries/* /path/to/tree-sitter-langs/queries/r
