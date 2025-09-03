" ripgrep.vim - Enhanced ripgrep integration with availability checking

" Prevent loading if already loaded or in compatible mode
if exists('g:loaded_ripgrep') || &compatible
  finish
endif
let g:loaded_ripgrep = 1

" Check if ripgrep is available
function! s:CheckRipgrepAvailable()
  return executable('rg')
endfunction

" Configure ripgrep only if available
function! s:SetupRipgrep()
  if !s:CheckRipgrepAvailable()
    return
  endif

  " Set ripgrep as the grep program
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow\ --sort\ path

  " Configure grepformat to parse ripgrep's output
  " %f: filename, %l: line number, %c: column number, %m: message
  set grepformat=%f:%l:%c:%m

  " Automatically open the quickfix window after a search
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost l* nested lwindow
endfunction

" Commands
command! RipgrepCheck call s:CheckRipgrepAvailable()
command! RipgrepSetup call s:SetupRipgrep()

" Auto-setup on plugin load
call s:SetupRipgrep()
