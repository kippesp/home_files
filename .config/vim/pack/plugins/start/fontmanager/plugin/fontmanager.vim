" Font Management Plugin
" Provides cross-platform font handling with size adjustment hotkeys and font cycling

if exists('g:loaded_fontmanager') || !has('gui_running')
  finish
endif
let g:loaded_fontmanager = 1

" Default font size
let g:default_font_size = get(g:, 'default_font_size', 12)
let g:current_font_size = g:default_font_size
let g:current_font_index = 0
let g:current_font_name = ''

" Platform-specific font lists (in order of preference)
let g:font_candidates = {
  \ 'windows': [
    \ 'Fira_Code_Retina',
    \ 'Meslo_LG_S',
    \ 'DejaVu_Sans_Mono',
    \ 'Cascadia_Mono',
    \ 'Cascadia_Code',
    \ 'Source_Code_Pro_Medium',
    \ 'Consolas',
    \ 'Courier_New',
    \ 'Lucida_Console'
  \ ],
  \ 'mac': [
    \ 'Menlo',
    \ 'Fira Code',
    \ 'PT Mono',
    \ 'Consolas',
    \ 'Source Code Pro',
    \ 'DejaVu Sans Mono',
    \ 'Courier New'
  \ ],
  \ 'linux': [
    \ 'Source Code Pro',
    \ 'DejaVu Sans Mono',
    \ 'Ubuntu Mono',
    \ 'Liberation Mono',
    \ 'Droid Sans Mono',
    \ 'Courier New',
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

function! s:FormatFontSpec(fontname, size)
  let platform = s:DetectPlatform()
  if platform == 'windows'
    return a:fontname . ':h' . a:size
  elseif platform == 'mac'
    return a:fontname . ':h' . a:size
  else
    return a:fontname . ' ' . a:size
  endif
endfunction

function! s:TestFont(fontname, size)
  let fontspec = s:FormatFontSpec(a:fontname, a:size)
  
  try
    let old_font = &guifont
    execute 'set guifont=' . escape(fontspec, ' ')
    " Check if the font was actually set
    if &guifont != '' && &guifont != old_font
      return 1
    else
      execute 'set guifont=' . escape(old_font, ' ')
      return 0
    endif
  catch
    return 0
  endtry
endfunction

function! s:SetFont(fontname, size)
  let fontspec = s:FormatFontSpec(a:fontname, a:size)
  execute 'set guifont=' . escape(fontspec, ' ')
  let g:current_font_name = a:fontname
endfunction

function! s:FindAvailableFont(size)
  let platform = s:DetectPlatform()
  let candidates = g:font_candidates[platform]
  
  for i in range(len(candidates))
    let font = candidates[i]
    if s:TestFont(font, a:size)
      let g:current_font_index = i
      return font
    endif
  endfor
  
  " Fallback to system default
  let g:current_font_index = -1
  if platform == 'windows'
    return 'Courier_New'
  elseif platform == 'mac'
    return 'Monaco'
  else
    return 'Monospace'
  endif
endfunction

function! FontManagerSetSize(size)
  let g:current_font_size = a:size
  if g:current_font_name != ''
    call s:SetFont(g:current_font_name, a:size)
  else
    let font = s:FindAvailableFont(a:size)
    call s:SetFont(font, a:size)
  endif
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

function! FontManagerCycleNext()
  let platform = s:DetectPlatform()
  let candidates = g:font_candidates[platform]
  let total_fonts = len(candidates)
  let start_index = g:current_font_index
  let found = 0
  
  " Try each font starting from the next one
  for i in range(total_fonts)
    let try_index = (start_index + i + 1) % total_fonts
    let font = candidates[try_index]
    
    if s:TestFont(font, g:current_font_size)
      let g:current_font_index = try_index
      call s:SetFont(font, g:current_font_size)
      echo "Font: " . font . " (size " . g:current_font_size . ")"
      let found = 1
      break
    else
      echom "Skipped unavailable font: " . font
    endif
  endfor
  
  if !found
    echo "No other fonts available!"
  endif
endfunction

function! FontManagerCyclePrev()
  let platform = s:DetectPlatform()
  let candidates = g:font_candidates[platform]
  let total_fonts = len(candidates)
  let start_index = g:current_font_index
  let found = 0
  
  " Try each font starting from the previous one
  for i in range(total_fonts)
    let try_index = (start_index - i - 1 + total_fonts) % total_fonts
    let font = candidates[try_index]
    
    if s:TestFont(font, g:current_font_size)
      let g:current_font_index = try_index
      call s:SetFont(font, g:current_font_size)
      echo "Font: " . font . " (size " . g:current_font_size . ")"
      let found = 1
      break
    else
      echom "Skipped unavailable font: " . font
    endif
  endfor
  
  if !found
    echo "No other fonts available!"
  endif
endfunction

function! FontManagerShowCurrent()
  echo "Current font: " . g:current_font_name . " (size " . g:current_font_size . ")"
endfunction

" Universal mappings using Leader key (works everywhere)
nnoremap <Leader>fi :call FontManagerIncrease()<CR>
nnoremap <Leader>fd :call FontManagerDecrease()<CR>
nnoremap <Leader>f0 :call FontManagerReset()<CR>
nnoremap <Leader>fn :call FontManagerCycleNext()<CR>
nnoremap <Leader>fp :call FontManagerCyclePrev()<CR>
nnoremap <Leader>ff :call FontManagerShowCurrent()<CR>

" Function key mappings (usually work well across platforms)
nnoremap <F9> :call FontManagerDecrease()<CR>
nnoremap <F10> :call FontManagerIncrease()<CR>
nnoremap <F11> :call FontManagerCycleNext()<CR>
nnoremap <F12> :call FontManagerCyclePrev()<CR>

" Commands for manual font management
command! FontIncrease call FontManagerIncrease()
command! FontDecrease call FontManagerDecrease()
command! FontReset call FontManagerReset()
command! FontNext call FontManagerCycleNext()
command! FontPrev call FontManagerCyclePrev()
command! FontShow call FontManagerShowCurrent()
command! -nargs=1 FontSize call FontManagerSetSize(<args>)

" Initialize font on startup
augroup FontManager
  autocmd!
  autocmd GUIEnter * call FontManagerSetSize(g:default_font_size)
augroup END
