" Highlight trailing whitespace for C files

" Only run once per buffer
if exists('b:did_trailing_whitespace_ftplugin')
  finish
endif
let b:did_trailing_whitespace_ftplugin = 1

" Function to enable trailing whitespace highlighting
function! s:EnableTrailingWhitespaceHighlight()
    if !exists('w:trailing_whitespace_match')
        let w:trailing_whitespace_match = matchadd('TrailingWhitespace', '\s\+$', -1)
    endif
endfunction

" Function to disable trailing whitespace highlighting
function! s:DisableTrailingWhitespaceHighlight()
    if exists('w:trailing_whitespace_match')
        call matchdelete(w:trailing_whitespace_match)
        unlet w:trailing_whitespace_match
    endif
endfunction

" Enable highlighting when entering the buffer
call s:EnableTrailingWhitespaceHighlight()

" Disable while typing, re-enable when leaving insert mode
augroup TrailingWhitespaceC
    autocmd! * <buffer>
    autocmd InsertEnter <buffer> call s:DisableTrailingWhitespaceHighlight()
    autocmd InsertLeave <buffer> call s:EnableTrailingWhitespaceHighlight()
augroup END