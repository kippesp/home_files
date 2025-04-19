" ftplugin/bril.vim

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=\#\ %s
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal nospell
setlocal nocindent
setlocal smartindent
setlocal cinwords=.
