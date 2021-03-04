if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setl syntax=cpp

" #########################################################################
" ## INDENT SETTINGS
" #########################################################################

" :help new-filetype

" see :help fo-table
setl formatoptions+=c   " auto-wrap comments using textwidth
setl formatoptions+=r   " insert the current comment leader after return
setl formatoptions+=o   " insert the current comment leader after insert
setl formatoptions+=q   " support comment formatting with 'gq'
setl formatoptions+=j   " when appropriate, remove comment leader on join
setl shiftwidth=2
setl softtabstop=2
setl cindent

" #########################################################################
" ## PROJECT-SPECIFIC CTAGS CONFIG
" #########################################################################

let ENABLE_CLANG_COMPLETE=-1

if ("$TAGSFILE" != "") && filereadable($TAGSFILE)
  set tags=$TAGSFILE

  " with ctags, don't use clang_complete
  let ENABLE_CLANG_COMPLETE=0
endif

" #########################################################################
" ## CLANG COMPLETE PLUGIN
" #########################################################################

" enable on non-windoz if python3 available
if ENABLE_CLANG_COMPLETE == -1
  if has('win32') || has('win64')                           " windows
                  || has('win32unix')|| has('win64unix')    " cygwin
    let ENABLE_CLANG_COMPLETE=0
  elseif has("conceal") && has("python3")
    let ENABLE_CLANG_COMPLETE=1
  else
    let ENABLE_CLANG_COMPLETE=0
  endif
endif
