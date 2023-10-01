[![MELPA](https://melpa.org/packages/tree-sitter-ess-r-badge.svg)](https://melpa.org/#/tree-sitter-ess-r)
[![MELPA Stable](https://stable.melpa.org/packages/tree-sitter-ess-r-badge.svg)](https://stable.melpa.org/#/tree-sitter-ess-r)
[![Build Status](https://github.com/ShuguangSun/tree-sitter-ess-r/actions/workflows/ci.yml/badge.svg)](https://github.com/ShuguangSun/tree-sitter-ess-r/actions)
[![License](http://img.shields.io/:license-gpl3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html)


# tree-sitter-ess-r

[R](https://r-project.org) with [Tree-sitter](https://tree-sitter.github.io/tree-sitter/) support.

## Installation

Clone this repository, or install from MELPA. Add the following to your `init.el`:

``` elisp
(require 'tree-sitter-ess-r)
(add-hook 'ess-r-mode-hook 'tree-sitter-ess-r-mode-activate)
```

If you use `use-package` you can install and configure with :

``` elisp
(use-package tree-sitter-ess-r
  :ensure t
  :after (ess)
  :hook (ess-r-mode . tree-sitter-ess-r-mode-activate))
```

or call interactively `M-x tree-sitter-ess-r-using-r-faces`

## Make tree-sitter to support R

You can install the [tree-sitter-langs](https://github.com/emacs-tree-sitter/tree-sitter-langs) which includes support
for R along with a number of other languages. Alternatively if you want to only add support for `tree-sitter-ess-r` to
your existing Tree-sitter languages you can install manually.

In the following `/path/to/tree-sitter-langs/` is the path of your
[tree-sitter-langs](https://github.com/emacs-tree-sitter/tree-sitter-langs) package.

### Linux

``` bash
git clone https://github.com/r-lib/tree-sitter-r.git && cd tree-sitter-r
gcc ./src/parser.c ./src/scanner.c -lstdc++ -fPIC -I./ -I./src/ -I./src/tree_sitter --shared -o r.so
cp ./r.so /path/to/tree-sitter-langs/langs/bin
mkdir /path/to/tree-sitter-langs/queries/r
cp ./queries/* /path/to/tree-sitter-langs/queries/r
```

### Windows (MINGW64)

``` bash
git clone https://github.com/r-lib/tree-sitter-r.git
gcc ./src/parser.c ./src/scanner.c -lstdc++ -fPIC -I./ -I./src/ -I./src/tree_sitter --shared -o r.dll
cp ./r.dll /path/to/tree-sitter-langs/langs/bin (/path/to/tree-sitter-langs/ is path of your tree-sitter-langs package)
mkdir /path/to/tree-sitter-langs/queries/r
cp ./queries/* /path/to/tree-sitter-langs/queries/r
```
