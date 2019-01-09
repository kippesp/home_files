" kippes.vim: a colorscheme
"    Maintainer: Paul Kippes
"          Date: Jan 10, 2005
"       Version: 1
"
"  Usage:
"  Put into your <.vimrc> file:
"    color kippes
"
"  Optional Modifiers:
"  let kippes_bold=1      : term, cterm, and gui receive bold modifier
"  let kippes_dark=1      : dark colors used (otherwise some terminals
"                              make everything bold, which can be all one
"                              color)
"  let kippes_underline=1 : assume that underlining works on your terminal
"                              Otherwise some groups will have dark-magenta
"                              background highlighting.
"  Examples:
"   iris       : let kippes_dark=1
"   Linux xterm: no modifiers needed

set background=dark
hi clear
if exists( "syntax_on" )
    syntax reset
endif
let g:colors_name="kippes"

if exists("kippes_bold") && kippes_bold != 0
 let s:usebold=",bold"
else
 let s:usebold=""
endif

if exists("kippes_dark") && kippes_dark != 0
 let s:black   = "black"
 let s:red     = "darkred"
 let s:green   = "darkgreen"
 let s:yellow  = "darkyellow"
 let s:blue    = "darkblue"
 let s:magenta = "darkmagenta"
 let s:cyan    = "darkcyan"
 let s:white   = "white"
else
 let s:black   = "black"
 let s:red     = "red"
 let s:green   = "green"
 let s:yellow  = "yellow"
 let s:blue    = "blue"
 let s:magenta = "magenta"
 let s:cyan    = "cyan"
 let s:white   = "white"
endif
if exists("kippes_underline") && kippes_underline != 0
 let s:underline= ",underline"
 let s:ulbg     = ""
else
 let s:underline= "none"
 if exists("kippes_dark")
  let s:ulbg     = "ctermbg=darkmagenta guibg=magenta4"
 else
  let s:ulbg     = "ctermbg=magenta guibg=magenta"
 endif
endif

exe "hi Blue           start=[m[34m      stop=[m[32m   ctermfg=".s:blue."                              guifg=blue        guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Comment        start=[m[37m      stop=[m[32m   ctermfg=".s:white."                             guifg=white                           term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Constant       start=[m[33m      stop=[m[32m   ctermfg=".s:cyan."                              guifg=cyan        guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Cursor                                                                                                 guifg=blue        guibg=green         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Cyan           start=[m[36m      stop=[m[32m   ctermfg=".s:cyan."                              guifg=cyan        guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Debug          start=[m[31m      stop=[m[32m   ctermfg=".s:red."                               guifg=magenta     guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Delimiter      start=[m[37m      stop=[m[32m   ctermfg=".s:white."                             guifg=white       guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi DiffAdd        start=[m[32;44m   stop=[m[32m   ctermfg=".s:cyan."      ctermbg=".s:blue."      guifg=cyan        guibg=blue          term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi DiffChange                                             ctermfg=".s:white."     ctermbg=".s:magenta."   guifg=white       guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi DiffDelete     start=[m[35m      stop=[m[32m   ctermfg=".s:blue."      ctermbg=".s:black."     guifg=blue        guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi DiffText                                               ctermfg=".s:white."     ctermbg=".s:red."       guifg=white       guibg=Red           term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Directory      start=[m[37m      stop=[m[32m   ctermfg=".s:white."                             guifg=white                           term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Error          start=[m[37;41m   stop=[m[32m   ctermfg=".s:white."     ctermbg=".s:red."       guifg=white       guibg=red           term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi ErrorMsg                                               ctermfg=".s:white."     ctermbg=".s:red."       guifg=White       guibg=Red           term=standout".s:usebold."         cterm=none".s:usebold."              gui=none".s:usebold
exe "hi FoldColumn                                             ctermfg=".s:black."     ctermbg=".s:white."     guifg=#40C0FF     guibg=Grey          term=standout".s:usebold."         cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Folded         start=[m[35;40m   stop=[m[32m   ctermfg=".s:black."     ctermbg=".s:cyan."      guifg=Cyan        guibg=#005080       term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Function       start=[m[43m      stop=[m[32m   ctermfg=".s:yellow."                            guifg=gold        guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Green          start=[m[32m      stop=[m[32m   ctermfg=".s:green."                             guifg=green       guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Identifier     start=[m[35m      stop=[m[32m   ctermfg=".s:magenta."                           guifg=magenta     guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Ignore                                                 ctermfg=".s:black  ."                           guifg=bg                              term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi IncSearch      start=[m[30;42m   stop=[m[32m   ctermfg=".s:black  ."   ctermbg=".s:white."     guifg=black       guibg=green         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi LineNr                                                 ctermfg=".s:yellow."    ctermbg=".s:blue."      guifg=grey        guibg=blue        term=none".s:underline.s:usebold." cterm=none".s:usebold."              gui=none".s:usebold
exe "hi MatchParen                                             ctermfg=".s:white."     ctermbg=".s:magenta."   guifg=white       guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Magenta        start=[m[35m      stop=[m[32m   ctermfg=".s:magenta."                           guifg=magenta     guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Menu                                                                                                   guifg=black       guibg=gray75        term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi ModeMsg                                                                                                                                      term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi MoreMsg                                                ctermfg=".s:yellow."                            guifg=yellow                          term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi NonText                                                ctermfg=".s:blue."                              guifg=Blue                            term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Normal         start=[m[32m      stop=[m[32m   ctermfg=".s:green."                             guifg=green       guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi PreProc        start=[m[37;44m   stop=[m[32m   ctermfg=".s:magenta."                           guifg=magenta                         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi PmenuSel       start=[m[34m      stop=[m[32m   ctermfg=".s:black."     ctermbg=".s:green."     guifg=black       guibg=green         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Question       start=[m[33m      stop=[m[32m   ctermfg=".s:yellow."                            guifg=yellow                          term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Red            start=[m[31m      stop=[m[32m   ctermfg=".s:red."                               guifg=red         guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Scrollbar                                                                                              guifg=gray80      guibg=gray70        term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Search         start=[m[34m      stop=[m[32m   ctermfg=".s:blue."      ctermbg=".s:yellow."    guifg=blue        guibg=Yellow        term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi SpecialKey     start=[m[30;45m   stop=[m[32m   ctermfg=".s:black."     ctermbg=".s:magenta."   guifg=black       guibg=magenta       term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Statement      start=[m[36m      stop=[m[32m   ctermfg=".s:cyan."                              guifg=cyan        guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi StatusLine     start=[m[30;46m   stop=[m[32m   ctermfg=".s:white."     ctermbg=".s:blue."      guifg=white       guibg=blue          term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi StatusLineNC   start=[m[30;42m   stop=[m[32m   ctermfg=".s:black."     ctermbg=".s:white."     guifg=black       guibg=white         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi String         start=[m[33m      stop=[m[32m   ctermfg=".s:cyan."                              guifg=cyan        guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Subtitle       start=[m[35m      stop=[m[32m   ctermfg=".s:magenta."                           guifg=magenta     guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Tags           start=[m[33;44m   stop=[m[32m   ctermfg=".s:yellow."    ctermbg=".s:blue."      guifg=yellow      guibg=blue3         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Title          start=[m[37m      stop=[m[32m   ctermfg=".s:white."                             guifg=white                           term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Todo           start=[m[37;45m   stop=[m[32m   ctermfg=".s:white."     ctermbg=".s:magenta."   guifg=white       guibg=magenta       term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Type           start=[m[33m      stop=[m[32m   ctermfg=".s:yellow."                            guifg=gold                            term=none".s:underline.s:usebold." cterm=none".s:underline.s:usebold."  gui=none".s:underline.s:usebold
exe "hi Underlined                                             ctermfg=".s:green."     ".s:ulbg."              guifg=green                           term=none".s:underline.s:usebold." cterm=none".s:underline.s:usebold."  gui=none".s:underline.s:usebold
exe "hi Unique         start=[m[34;47m   stop=[m[32m   ctermfg=".s:blue."      ctermbg=".s:white."     guifg=blue3       guibg=white         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi AltUnique      start=[m[35;47m   stop=[m[32m   ctermfg=".s:magenta."   ctermbg=".s:white."     guifg=magenta     guibg=white         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi AltAltUnique   start=[m[30;47m   stop=[m[32m   ctermfg=".s:black."     ctermbg=".s:white."     guifg=black       guibg=white         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi VertSplit      start=[m[30;46m   stop=[m[32m   ctermfg=".s:black."     ctermbg=".s:blue."      guifg=white       guibg=blue          term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Visual         start=[m[40;32m   stop=[m[32m   ctermfg=black           ctermbg=green           guifg=Grey        guibg=fg            term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi VisualNOS                                                                      ".s:ulbg."                                                    term=none".s:underline.s:usebold." cterm=none".s:underline.s:usebold."  gui=none".s:underline.s:usebold
exe "hi WarningMsg     start=[m[30;43m   stop=[m[32m   ctermfg=".s:black."     ctermbg=".s:yellow."    guifg=black       guibg=yellow        term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi White          start=[m[37m      stop=[m[32m   ctermfg=".s:white."                             guifg=white       guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi WildMenu                                               ctermfg=".s:black."     ctermbg=".s:cyan."      guifg=Black       guibg=cyan          term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi Yellow         start=[m[33m      stop=[m[32m   ctermfg=".s:yellow."                            guifg=yellow      guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi lCursor                                                                                                guifg=bg          guibg=fg            term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi AltConstant      start=[m[33;40m   stop=[m[32m   ctermfg=".s:yellow."    ctermbg=".s:black."     guifg=yellow      guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi AltFunction      start=[m[36;40m   stop=[m[32m   ctermfg=".s:cyan."      ctermbg=".s:black."     guifg=cyan        guibg=black         term=none".s:usebold."             cterm=none".s:usebold."              gui=none".s:usebold
exe "hi AltType          start=[m[4;32;40m stop=[m[32m   ctermfg=".s:green."     ctermbg=".s:black."     guifg=seagreen1   guibg=black         term=none".s:underline.s:usebold." cterm=none".s:underline.s:usebold."  gui=none".s:underline.s:usebold
" vim: nowrap
