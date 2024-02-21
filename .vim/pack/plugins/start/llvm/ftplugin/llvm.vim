" Vim filetype plugin file
" Language: LLVM Assembly
" Maintainer: The LLVM team, http://llvm.org/

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal softtabstop=2 shiftwidth=2
setlocal expandtab
setlocal comments=:;

setlocal formatoptions+=r   " insert the current comment leader after return
setlocal formatoptions+=o   " insert the current comment leader after insert
