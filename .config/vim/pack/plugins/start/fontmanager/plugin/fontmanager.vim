" Font Management Plugin
" Provides cross-platform font handling with size adjustment hotkeys

if exists('g:loaded_fontmanager') || !has('gui_running')
  finish
endif
let g:loaded_fontmanager = 1

" Default font size
let g:default_font_size = get(g:, 'default_font_size', 12)
let g:current_font_size = g:default_font_size

" Platform-specific font lists (in order of preference)
let g:font_candidates = {
  \ 'windows': [
    \ 'Cascadia_Mono', 'Consolas', 'Cascadia_Code',
    \ 'Source_Code_Pro', 'DejaVu_Sans_Mono', 'Courier_New',
    \ 'Lucida_Console'
  \ ],
  \ 'mac': [
    \ 'SF Mono', 'Menlo', 'Monaco', 'Consolas',
    \ 'Source Code Pro', 'DejaVu Sans Mono', 'Courier New'
  \ ],
  \ 'linux': [
    \ 'Source Code Pro', 'DejaVu Sans Mono',
    \ 'Ubuntu Mono', 'Liberation Mono', 'Droid Sans Mono', 'Courier New',
    \ 'Monospace'
  \ ]
\ }

function! s:DetectPlatform()
  if has('win32') || has('win64')
    return 'windows'
  elseif has('mac') || has('macunix')
    return 'mac'
  else
    return 'linux'
  endif
endfunction

function! s:TestFont(fontname, size)
  let platform = s:DetectPlatform()
  if platform == 'windows'
    let fontspec = a:fontname . ':h' . a:size
  elseif platform == 'mac'
    let fontspec = a:fontname . ':h' . a:size
  else
    let fontspec = a:fontname . ' ' . a:size
  endif
  
  try
    let old_font = &guifont
    execute 'set guifont=' . escape(fontspec, ' ')
    if &guifont != ''
      return fontspec
    else
      execute 'set guifont=' . escape(old_font, ' ')
      return ''
    endif
  catch
    return ''
  endtry
endfunction

function! s:FindAvailableFont(size)
  let platform = s:DetectPlatform()
  let candidates = g:font_candidates[platform]
  
  for font in candidates
    let result = s:TestFont(font, a:size)
    if result != ''
      return result
    endif
  endfor
  
  " Fallback to system default
  if platform == 'windows'
    return 'Courier_New:h' . a:size
  elseif platform == 'mac'
    return 'Monaco:h' . a:size
  else
    return 'Monospace ' . a:size
  endif
endfunction

function! FontManagerSetSize(size)
  let g:current_font_size = a:size
  let fontspec = s:FindAvailableFont(a:size)
  execute 'set guifont=' . escape(fontspec, ' ')
endfunction

function! FontManagerIncrease()
  let new_size = g:current_font_size + 1
  call FontManagerSetSize(new_size)
  echo "Font size: " . g:current_font_size
endfunction

function! FontManagerDecrease()
  let new_size = max([6, g:current_font_size - 1])
  call FontManagerSetSize(new_size)
  echo "Font size: " . g:current_font_size
endfunction

function! FontManagerReset()
  call FontManagerSetSize(g:default_font_size)
  echo "Font size reset to: " . g:current_font_size
endfunction

" Font size adjustment hotkeys
" Alt+Ctrl+. to increase font size
nnoremap <M-C-.> :call FontManagerIncrease()<CR>
" Alt+Ctrl+, to decrease font size  
nnoremap <M-C-,> :call FontManagerDecrease()<CR>
" Alt+Ctrl+0 to reset to default size
nnoremap <M-C-0> :call FontManagerReset()<CR>

" Alternative mappings for systems where Meta key doesn't work well
" Ctrl+> to increase font size
nnoremap <C->> :call FontManagerIncrease()<CR>
" Ctrl+< to decrease font size
nnoremap <C-<> :call FontManagerDecrease()<CR>

" Commands for manual font management
command! FontIncrease call FontManagerIncrease()
command! FontDecrease call FontManagerDecrease()
command! FontReset call FontManagerReset()
command! -nargs=1 FontSize call FontManagerSetSize(<args>)

" Initialize font on startup
augroup FontManager
  autocmd!
  autocmd GUIEnter * call FontManagerSetSize(g:default_font_size)
augroup END
