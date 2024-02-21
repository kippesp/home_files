"
" .vimrc common file
"
" Maintainer: Paul Kippes
" Original version: 1996

" #########################################################################
" ## PLATFORM SETTINGS
" #########################################################################

if has('win32') || has('win64')
  set runtimepath^=~/.vim
  "set runtimepath=~/.vim,$VIMRUNTIME
  set packpath=~/.vim,
endif

" set path to user's .vim
if has('win32') || has('win64')             " windows
  let $VIMHOME = $VIM."vimfile"
elseif has('win32unix') || has('win64unix') " cygwin/mingw
  let $VIMHOME = $HOME."/.vim"
else                                        " unix/bsd
  let $VIMHOME = $HOME."/.vim"
endif

" #########################################################################
" ## PLUGIN SETTINGS
" #########################################################################

filetype plugin indent on             " allow plugins to determine indentation

" #########################################################################
" ## ENVIRONMENT AND CLIENT CAPABILITIES/RESTRICTIONS
" #########################################################################

" Do not restore the screen on returning to prompt
set t_ti= t_te=

" No terminal audible bells
set t_vb=
set visualbell

" #########################################################################
" ## VIM USABILITY ADJUSTMENTS (ALL FILE TYPES)
" #########################################################################

" ## Vim Extensions and Miscellaneous

set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set noequalalways       " Do not resize windows when splitting
set splitbelow          " When splitting windows, current window is the lower
set history=75          " keep 75 lines of command line history
let mapleader=','       " set the <leader>
set modelines=1         " process a single modeline (as opposed to ...?)

" ## Mouse and Clipboard Settings

set mouse=nhv           " Enable console mouse for Normal, Visual, and Help
if has('X11')
  set clipboard=unnamedplus     " Use '+' register
else
  set clipboard=autoselect      " (text mode) Use system clipboard
  set clipboard+=unnamed        " Use '*' register
endif

" ## Search/Replace Behavior

set ignorecase          " Ignore case when searching
set smartcase           " Allow override of case-sensitive search patterns
set incsearch           " Incremental search (highlight while searching)
set infercase           " Keyword completion isn't picky about case
set gdefault            " Substitute all matches in a line
set hlsearch            " Highlight the last search

" Clear search highlights with a double tap, <esc><esc>
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Key mappings to keep incremental searches in the center
:nnoremap n nzz
:nnoremap N Nzz
:nnoremap * *zz
:nnoremap # #zz
:nnoremap g* g*zz
:nnoremap g# g#zz

" TODO: possibly per ft:

" Delete comment character when joining commented lines.
set formatoptions+=j

" Continue comments on <return> for ins/norm modes
set formatoptions+=cro

" ## File Settings

set autowriteall        " write files when switching files

"
" Default tab settings (overridden by specific file types)
"

set expandtab           " expand tab into spaces
set shiftwidth=4
set softtabstop=4       " existing tabs will remain standard 8

" ## Enable and customize wild-menu feature

set wildmenu            " Enable wildmenu completion
set wildmode=list:longest,list:full
set wildignore=*.o,*.tar,*.tgz,*.a

"
" Key mappings for tab pages
"
map <leader>to :tabnew %<CR>
map <leader>tc :tabclose<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>

"
" Key mappings for QuickFix buffer
"

map <C-n> :cn<C-m>
map <C-p> :cp<C-m>

"
" Command Aliases
"
nmap :W :w
nmap :Q :q
nmap :B :b
nmap :E :e
nmap :qA :qa

"
" Abbreviations And Typos Corrections
"
iabbrev teh the

" #########################################################################
" ## VIM LOOK AND FEEL SETTINGS (ALL FILE TYPES, ALL CLIENT TYPES)
" #########################################################################

" ## Interface view adjustments (non-editor)

set ruler               " display ruler at bottom
set laststatus=2        " status line always on
set showcmd             " terse status line updates

" ## Editor view adjustments

set colorcolumn=78      " highlight a "soft" right bounds
set cpoptions+=$        " put the nice little $ when we change text

set scrolloff=2         " Keep 2 lines above/below cursor line
set sidescroll=1        " Scroll sideways 1 position at a time
set sidescrolloff=5     " Keep 5 characters to the right/left of cursor when side scrolling
set listchars+=precedes:<,extends:>   " Use < and > to indicated text beyond visible area
" TODO: precedes not functioning

" TODO: see https://jeffkreeftmeijer.com/vim-number/
" for buffer switching
set number              " Enable line numbering
"set cursorline "TODO: (future) use to alter current line's line number color

" Resize splits when window is resized
autocmd VimResized * wincmd =

" ## GUI settings
set guioptions-=r       " No vertical scrollbar on right
set guioptions-=L       " No vertical scrollbar on left when split
set guioptions-=m       " No menu bar
set guioptions-=T       " No toolbar
set guicursor+=i-n-v-c:blinkon0 " No blinking curser

if has('gui_running')
  if has('win32') || has('win64')
    set guifont=Lucida_Console:h10
    winsize 130 50
"  elseif has('gui_gtk2')
"    set guifont="Courier 10"
"  elseif has('gui_gtk')
"    set guifont="Ubuntu Mono 12"
"    set guifont="Monospace 10,Courier 10"
"  elseif has('gui_kde')
"  else
"    set guifont=LucidaTypewriter
  endif
endif

if &term =~ '^xterm\\|rxvt'
" solid underscore
"let &t_SI .= "\<Esc>[4 q"
" solid block
  let &t_EI .= "\<Esc>[2 q"
" 1 or 0 -> blinking block
" 3 -> blinking underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
endif

" #########################################################################
" ## COLOR SETTINGS
" #########################################################################

syntax on               " Enable syntax highlighting
colorscheme kippes

" #########################################################################
" ## PLUGIN SETTINGS
" #########################################################################

" Store the local vimrc file sourcing answer when it is a capial letter
let g:localvimrc_persistent=1

" vim:expandtab:softtabstop=2 shiftwidth=2
