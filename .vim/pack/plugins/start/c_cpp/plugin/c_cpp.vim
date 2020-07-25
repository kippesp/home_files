if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

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
