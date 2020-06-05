"
" .vimrc common file
"
" Maintainer: Paul Kippes
" Original version: 1996

" #########################################################################
" ## PLATFORM SETTINGS
" #########################################################################

if has('win32') || has('win64')
 set runtimepath=~/.vim,$VIMRUNTIME
endif

let ENABLE_CLANG_COMPLETE=0
if has("conceal") && has("python3")
  let ENABLE_CLANG_COMPLETE=1
endif

" set path to user's .vim
if has('win32') || has('win64')             " windows
  let $VIMHOME = $VIM."vimfile"
  let ENABLE_CLANG_COMPLETE=0
elseif has('win32unix') || has('win64unix') " cygwin
  let $VIMHOME = $HOME."/.vim"
  let ENABLE_CLANG_COMPLETE=0
else                                        " unix/bsd
  let $VIMHOME = $HOME."/.vim"
endif

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

set nocompatible        " Use Vim defaults (much better!)
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
"                       " than 50 lines of registers
set noequalalways       " Do not resize windows when splitting
set splitbelow          " When splitting windows, current window is the lower
set history=75          " keep 75 lines of command line history
let mapleader=','       " set the <leader>
set modelines=1         " process a single modeline (as opposed to ...?)

" ## Mouse and Clipboard Settings

set mouse=nhv           " Enable console mouse for Normal, Visual, and Help
set clipboard=autoselect,unnamed        " (text mode) Attempt to place Visual mode selected text
                                        "    and yank text in windowing system's clipboard
" ## Search/Replace Behavior

set ignorecase          " Ignore case when searching
set smartcase           " Allow override of case-sensitive search patterns
set incsearch           " Incremental search (highlight while searching)
set infercase           " Keyword completion isn't picky about case
set gdefault            " Substitute all matches in a line
set hlsearch            " Highlight the last search

" Key mappings to keep incremental searches in the center
:nnoremap n nzz
:nnoremap N Nzz
:nnoremap * *zz
:nnoremap # #zz
:nnoremap g* g*zz
:nnoremap g# g#zz

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

"WIP
"Check &diff == 1 for vimdiff mode
" https://vi.stackexchange.com/questions/2705/create-mappings-that-only-apply-to-diff-mode
":diffget REMOTE
":diffget BASE
":diffget LOCAL

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

" ## Editor view adjustments

set colorcolumn=78      " highlight a "soft" right bounds
set cpoptions+=$        " put the nice little $ when we change text

set scrolloff=2         " Keep 2 lines above/below cursor line
set sidescroll=1        " Scroll sideways 1 position at a time
set sidescrolloff=5   " Keep 5 characters to the right/left of cursor when side scrolling
set listchars+=precedes:<,extends:>   " Use < and > to indicated text beyond visible area
" TODO: precedes not functioning

" TODO: see https://jeffkreeftmeijer.com/vim-number/
" for buffer switching
"set relativenumber      " Enable relative vertical line numbering
set number               " Enable line numbering
"set cursorline "TODO: (future) use to alter current line's line number color

" ## GUI settings
set guioptions-=r              " No vertical scrollbar on right
set guioptions-=L              " No vertical scrollbar on left when split
set guioptions-=m              " No menu bar
set guioptions-=T              " No toolbar
set guicursor+=i-n-v-c:blinkon0 " No blinking curser

" vim:expandtab:softtabstop=2 shiftwidth=2
