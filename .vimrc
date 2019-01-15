"
" .vimrc common file
"
" Maintainer: Paul Kippes
" Original version: 1996

" TODO: http://vim.wikia.com/wiki/Indenting_source_code

" TODO: https://github.com/keith/swift.vim
"       swift and syntastic

if version < 600
 echo "This configuration file, .vimrc, assumes a modern vim."
 echo "Run with -v option: 'vim -v [FILE]'"
endif

" ## Platform settings
if has('win32') || has('win64')
 set runtimepath=~/.vim,$VIMRUNTIME
endif

" #########################################################################
" ## ENVIRONMENT AND CLIENT CAPABILITIES/RESTRICTIONS
" #########################################################################

" TODO: Determine in console
" TODO: Determine in GUI
" TODO: Get 'gqap' or other to reflow more sanely

" Do not restore the screen on returning to prompt
set t_ti= t_te=

" #########################################################################
" ## VIM USABILITY ADJUSTMENTS (ALL FILE TYPES)
" #########################################################################

"if has('gui_running')
"  if platform == "win"
"    set guifont=ProggySquareTTSZ:h12 " Set font
"    "winpos 110 30
"    winsize 130 50
"  elseif has('gui_gtk2')
"    set guifont="Courier 10"
"  elseif has('gui_gtk')
"    set guifont="Ubuntu Mono 12"
"    set guifont="Monospace 10,Courier 10"
"  elseif has('gui_kde')
"  else
"    set guifont=LucidaTypewriter
"  endif
"endif

" ## Vim Extensions and Miscellaneous
set nocompatible        " Use Vim defaults (much better!)
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
"                       " than 50 lines of registers
"set hidden              " Allow hidden buffers
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

" ## File Settings

set autowriteall        " write files when switching files
"set patchmode=.org  " Rename original file with .org extension

"
" Default Tab settings (Overridden by Specific File Types)
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
set relativenumber      " Enable relative vertical line numbering
set number              " Enable current line

" ## GUI settings
set guioptions-=r       " No vertical scrollbar on right
set guioptions-=m       " No menu bar
set guioptions-=T       " No toolbar
set guicursor+=n-v-c:blinkon0

"if version >= 600
" if exists("DEJAVU")
"   finish
" else
"   let DEJAVU = 1
" endif
"endif
"
""
"" Determine platform
""
"if &term == "win32" || &term == "pcterm" || has("gui_win32")
" let platform="win"
"else
" let platform="unix"
"endif
"
""
"" Check for non-ansi emulation
""
"if platform == "unix"
" if &term == "vt220" || &term == "vt52" || &term == "ansi"
"   let &term = "vt100"
" endif
"
"endif
"
""
"" Install 3rd party stuff
""
"if platform == "unix"
" "
" " Install Stephen Riehm's bracketing system
" "
""  let $SCRIPT_=$HOME . "/vim/macros/vim-bracketing/vim-bracketing-current/macros/bracketing.meta.vim"
""  if filereadable($SCRIPT_)
""    source $SCRIPT_
""  endif
"
" "
" " Install Dr. Campbell's diffwin script
" "
""  let $SCRIPT_=$HOME . "/usr-solaris/share/vim/vim-current/macros/diffwin.vim"
""  if filereadable($SCRIPT_)
""    source $SCRIPT_
""  endif
"
" "
" " Install Dr. Campbell's flist script
" "
" if version >= 600
"   let flist_options="-ax"
""    let $SCRIPT_=$HOME . "/usr-solaris/share/vim/vim-usr/macros/flist.vim"
""    if filereadable($SCRIPT_)
""      source $SCRIPT_
"      runtime macros/flist.vim
"
"     nmap \fl :let flist_options="-Tfs"<CR>:Flist<CR>:let flist_options="-Tg -asx"<CR>
""    endif
" endif
"
" "
" " Load Man page viewer
" "
" :runtime! ftplugin/man.vim
"endif
"
"if platform == "win"
"  set guifont=ProggySquareTTSZ:h12 " Set font
"  "winpos 110 30
"  winsize 130 50
"else
"  set guifont=LucidaTypewriter
"endif
"
""
"" Popup menu settings
"
":set completeopt=longest,menuone
":inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
"

"
" Editing settings
"
"set showmatch           " Enable flash when matching brackets are found
"set matchtime=2         " time to delay on matched bracket
"set smartindent         " use smartindent when not using cindent

""
"" Scroll settings
""
"if version >= 600
"endif
"set guioptions+=a       " (gui mode)  Attempt to place Visual mode selected text
"                       "    in windowing system's clipboard

"map <M-k> <C-y>         " Scroll window down
"map <M-j> <C-e>         " Scroll window up
"map <M-l> zl            " Scroll window right
"map <M-h> zh            " Scroll window left
"nmap <M-+> <C-W>+       " Increase current window height by 1
"nmap <M--> <C-W>-       " Decrease current window height by 1
"if has("folding")
" nmap \tw :botright ptag <C-R>=expand("<cword>")<CR><CR>:silent!
"       \ wincmd P<CR>zv:wincmd p<CR>   " Give preview-tag command a easy interface
"else
" nmap \tw :ptag <C-R>=expand("<cword>")<CR><CR>        " Give preview-tag command a easy interface
"endif
"nmap \ts :ts <C-R>=expand("<cword>")<CR><CR>    " Give select-tag command a easy interface
"if version >= 600
" nmap <M->> <C-W>>     " Increase current window width by 1
" nmap <M-<> <C-W><     " Decrease current window width by 1
"endif
"
""
"" cscope key mappings
""
"if has("cscope")
" " add any cscope database in current directory
" if filereadable("cscope.out")
"   cs add cscope.out  
" endif
"
" " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
" set cscopetag
"
" " check ctags for definition of a symbol before checking cscope
" set csto=1
"
"
"" Support for cscope program
""       tag searches    : Use tags file
""       cscope searches : Use cscope database.  On failure search tags.
""
""       cscope usage:
""               \cs   symbol:   find all references to the token under cursor
""               \cg   global:   find global definition(s) of the token under cursor
""               \cc   calls:    find all calls to the function name under cursor
""               \ct   text:     find all instances of the text under cursor
""               \ce   egrep:    egrep search for the word under cursor
""               \cf   file:     open the filename under cursor
""               \ci   includes: find files that include the filename under cursor
""               \cd   called:   find functions that function under cursor calls
" nmap \cs :cs find s <C-R>=expand("<cword>")<CR><CR>
" nmap \cg :cs find g <C-R>=expand("<cword>")<CR><CR>
" nmap \cc :cs find c <C-R>=expand("<cword>")<CR><CR>
" nmap \ct :cs find t <C-R>=expand("<cword>")<CR><CR>
" nmap \ce :cs find e <C-R>=expand("<cword>")<CR><CR>
" nmap \cf :cs find f <C-R>=expand("<cword>")<CR><CR>
" nmap \ci :cs find i <C-R>=expand("<cfile>")<CR><CR>
" nmap \cd :cs find d <C-R>=expand("<cfile>")<CR><CR>
"
"" Horizontially split the window with the found result
" nmap \chs :scs find s <C-R>=expand("<cword>")<CR><CR>
" nmap \chg :scs find g <C-R>=expand("<cword>")<CR><CR>
" nmap \chc :scs find c <C-R>=expand("<cword>")<CR><CR>
" nmap \cht :scs find t <C-R>=expand("<cword>")<CR><CR>
" nmap \che :scs find e <C-R>=expand("<cword>")<CR><CR>
" nmap \chf :scs find f <C-R>=expand("<cword>")<CR><CR>
" nmap \chi :scs find i <C-R>=expand("<cfile>")<CR><CR>
" nmap \chd :scs find d <C-R>=expand("<cfile>")<CR><CR>
"
"" Vertically split the window with the found result
" nmap \cvs :vert scs find s <C-R>=expand("<cword>")<CR><CR>
" nmap \cvg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
" nmap \cvc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
" nmap \cvt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
" nmap \cve :vert scs find e <C-R>=expand("<cword>")<CR><CR>
" nmap \cvf :vert scs find f <C-R>=expand("<cword>")<CR><CR>
" nmap \cvi :vert scs find i <C-R>=expand("<cfile>")<CR><CR>
" nmap \cvd :vert scs find d <C-R>=expand("<cfile>")<CR><CR>
"endif

"
" Autocommands for specific file types
"

" C++ and C
augroup cppgroup
  au!

  autocmd BufNewFile,BufRead *.cpp,*.hpp,*.c,*.h setl formatoptions+=croqj shiftwidth=2 softtabstop=2 cindent comments=sr:/*,mb:*,el:*/,://

  " For vim-cpp-enhanced-highlight in after/syntax
  autocmd BufNewFile,BufRead *.cpp,*.hpp,*.c,*.h let g:cpp_class_scope_highlight=1
  autocmd BufNewFile,BufRead *.cpp,*.hpp,*.c,*.h let g:cpp_experimental_template_highlight=1
augroup end

" ObjectiveC
augroup objc
  au!

  autocmd BufNewFile,BufRead *.m,*.mm setl formatoptions+=croqj shiftwidth=4 softtabstop=4 cindent comments=sr:/*,mb:*,el:*/,://
augroup end

" Metal
augroup metal
  au!

  autocmd BufNewFile,BufRead *.metal setl formatoptions+=croqj shiftwidth=2 softtabstop=2 cindent comments=sr:/*,mb:*,el:*/,://
augroup end

" CMakeLists.txt
augroup cmakelists
  au!

  autocmd BufNewFile,BufRead CMakeLists.txt setl shiftwidth=2 softtabstop=2
augroup end

" Makefiles
augroup makefiles
  au!

  autocmd BufNewFile,BufRead Makefile,Makefile.am,makefile setl softtabstop=0 shiftwidth=8 noexpandtab
augroup END


augroup python
  " Do not unindent comments
  autocmd FileType python setlocal autoindent comments=b:#|inoremap # X#

  " Indent code blocks
  autocmd FileType python setlocal si cinwords=if,elif,else,for,while,try,except,finally,def,class

  " Display tabs at the beginning of a line in Python mode as bad
  "autocmd BufRead,BufNewFile *.py,*.pyw match pythonSpaceError /^\t\+/

  " Wrap text after a certain number of characters
  autocmd BufRead,BufNewFile *.py,*.pyw setl textwidth=79

  " Indent two spaces
  autocmd BufRead,BufNewFile *.py,*.pyw,*.yaml setl shiftwidth=2 softtabstop=2
augroup END

"if version >= 600
" if has("autocmd")
"   "
"   " .php
"   "
"   augroup phpscr
"     "
"     " Remove all phpscr autocommands
"     "
"     au!
"
"     "
"     " PHP settings
"     "
"      function! PhpSettings()
"        :set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
"        :highlight rightMargin term=bold ctermfg=blue guifg=blue
"        :match rightMargin /.\%>96v/
"      endfunction
"
"     " When starting to edit a file:
"     "   For *.php files set formatting of comments and set C-indenting on.
"     "   For other files switch it off.
"     autocmd BufNewFile,BufRead *.php,*.ihtml,*.html,*.inc :call PhpSettings()
"   augroup END
"
"   "
"   " .java
"   "
"   augroup javascr
"     "
"     " Remove all javascr autocommands
"     "
"     au!
"
"     "
"     " Java settings
"     "
"
"     " When starting to edit a file:
"     "   For *.java files set C-indenting on.
"     autocmd BufNewFile,BufRead *.java set formatoptions=croql cindent
"   augroup END
"
"   "
"   " .c, cpp
"   "
"   augroup cprog
"     "
"     " Remove all cprog autocommands
"     "
"     au!
"
"     "
"     " Add function to #define out C code
"     "
"       function! RemoveCCode()
"         execute "normal `>o0\<C-d>#endif /* REMOVED_BLOCK_" . b:removed_count .
"             \ " */\<Esc>'<O0\<C-d>#ifdef REMOVED_BLOCK_" . b:removed_count . "\<Esc>j"
"         let b:removed_count = b:removed_count + 1
"       endfunction
"
"     " When starting to edit a file:
"     "   For *.c and *.h files set formatting of comments and set C-indenting on.
"     "   For other files switch it off.
"     " Removed comments settings since I couldn't figure out if it was necessary anymore. (PK 3/29/05)
"     "autocmd BufNewFile,BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
"     autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hpp set formatoptions=croq shiftwidth=2 softtabstop=2 cindent comments=sr:/*,mb:*,el:*/,://
"
"     " Allow \xx to #define-out a block of C code
"     autocmd BufNewFile,BufRead *.c,*.h,*.cc,*.cpp let b:removed_count=1 | vmap \xx <Esc>:call RemoveCCode()<Return>
"
"     " Key mappings for tal Comment Formatter
"     autocmd BufNewFile,BufRead *.c,*.h,*.cc vmap ,v ! ~/perl/cor2.pl -l c -b i<CR>
"     autocmd BufNewFile,BufRead *.c,*.h,*.cc vmap ,c ! ~/perl/cor2.pl -l c -b c<CR>
"     autocmd BufNewFile,BufRead *.c,*.h,*.cc vmap ,b ! ~/perl/cor2.pl -l c -b o<CR>
"     autocmd BufNewFile,BufRead *.c,*.h,*.cc vmap ,r ! ~/perl/cor2.pl -l c -r<CR>
"
"     " Prevent insertion of '*' at the beginning of every line in a comment
"     autocmd BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r
"
"     " Wrap text after a certain number of characters
"     autocmd BufRead,BufNewFile *.c,*.h set textwidth=79
"
"     " Use clang-format
"     map <leader>cf :pyf /home/pmkippes/.vim/clang-format.py<cr>
"     vmap <leader>cf :pyf /home/pmkippes/.vim/clang-format.py<cr>
"   augroup END
"
"   "
"   " .txt, .tex
"   "
"   augroup text
"     autocmd BufNewFile,BufRead *.txt,*.tex setlocal linebreak
"     autocmd BufNewFile,BufRead *.txt,*.tex setlocal shiftwidth=2 softtabstop=2
"
"     " Map movement for visual line movement
"     autocmd BufEnter *.txt,*.tex map j gj
"     autocmd BufEnter *.txt,*.tex map k gk
"     autocmd BufLeave *.txt,*.tex map j j
"     autocmd BufLeave *.txt,*.tex map k k
"   augroup END
"
"   "
"   " .f
"   "
"   augroup fortran
"      function! FortranSettings()
"        :set ts=6
"        ":highlight rightMargin term=bold ctermbg=lightblue guifg=blue
"        ":match rightMargin /.\%7v/
"        :highlight rightMargin term=bold ctermbg=lightblue guifg=blue guibg=magenta
"        :match rightMargin /.\%>73v/
"      endfunction
"
"     " When starting to edit a file:
"     "   For *.php files set formatting of comments and set C-indenting on.
"     "   For other files switch it off.
"     autocmd BufNewFile,BufRead *.f :call FortranSettings()
"   augroup END
"
"   "
"   " .r
"   "
"   augroup rprog
"     " Remove all rprog autocommands
"     au!
"
"     autocmd BufNewFile,BufRead *.r,*.R set formatoptions=croq shiftwidth=2 softtabstop=2 cindent comments=b:#|inoremap # X#
"   augroup END
" endif
"endif

"
" Color-terminal highlighting settings
"
if &t_Co > 2 || has("gui_running")
 syntax on             " Enable syntax highlighting
 set hlsearch          " Highlight the last search

" " Use the below highlight group when displaying bad whitespace is desired
" let c_space_errors=1  " Highlight C-Spacing "errors"
" let java_space_errors=1  " Highlight Java-Spacing "errors"
" let python_highlight_space_errors=1  " Highlight Python-Spacing "errors"
"
 colorscheme kippes
" hi Search     cterm=NONE      ctermbg=cyan    ctermfg=black
" hi IncSearch  cterm=NONE      ctermbg=yellow  ctermfg=black
" hi String     cterm=NONE
" hi Special    ctermfg=magenta
" hi Special    cterm=NONE
endif

""
"" Custom commands
""
"command Cfd :cd %:h     " Change to the current file's directory
"
""
"" Source additional .vimrc files
""
"if filereadable(expand("$HOME/.vimrc_local"))
"  source $HOME/.vimrc_local
"endif
"
"if platform == "win" && filereadable(expand("$APPDATA/_vimrc_local"))
"  source $APPDATA/_vimrc_local
"endif
"
"if filereadable(expand("./.vimrc_local"))
"  source ./.vimrc_local
"endif
"
"let g:miniBufExplSplitBelow=0

command SpellEn :setlocal spell spelllang=en_us
"command SpellFr :setlocal spell spelllang=fr_fr

" vim:expandtab:softtabstop=2 shiftwidth=2
