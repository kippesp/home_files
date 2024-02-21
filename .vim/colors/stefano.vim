" Vim color file
" Maintainer:	Shian Lee 
" Last Change:	2014 Mar 6 (for vim 7.4)
" Remark:	"industry" stands for 'industrial' color scheme. In industrial
"		HMI (Human-Machine-Interface) programming, using a standard color
"               scheme is mandatory in many cases (in traffic-lights for example): 
"               LIGHT_RED is	    'Warning' 
"               LIGHT_YELLOW is	    'Attention' 
"               LIGHT_GREEN is	    'Normal' 
"               LIGHT_MAGENTA is    'Warning-Attention' (light RED-YELLOW)
"               LIGHT_CYAN is	    'Attention-Normal'  (light YELLOW-GREEN).
"               BLACK is	    Dark-High-Contrast Background for maximum safety.
"               BLUE is		    Shade of BLACK (not supposed to get attention).
"
"               Industrial color scheme is by nature clear, safe and productive. 
"               Yet, depends on the file type's syntax, it might appear incorrect. 

" Reset to dark background, then reset everything to defaults:
set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "industry"

" First set Normal to regular white on black text colors:
hi Normal ctermfg=LightGray ctermbg=Black guifg=#dddddd	guibg=Black

" Syntax highlighting (other color-groups using default, see :help group-name):
hi Comment      cterm=NONE ctermfg=DarkCyan                         gui=NONE guifg=#00aaaa
hi Constant     cterm=NONE ctermfg=Blue                             gui=NONE guifg=#00ffff
hi Identifier   cterm=NONE ctermfg=LightMagenta                     gui=NONE guifg=#ff00ff
hi Function     cterm=NONE ctermfg=Green                            gui=NONE guifg=#00ff00
hi Statement    cterm=NONE ctermfg=White                            gui=bold guifg=#ffffff
hi PreProc      cterm=NONE ctermfg=LightYellow                      gui=NONE guifg=#ffff00
hi Type         cterm=NONE ctermfg=LightGreen                       gui=bold guifg=#00ff00
hi Special      cterm=NONE ctermfg=LightRed                         gui=NONE guifg=#ff0000
hi Delimiter    cterm=NONE ctermfg=Yellow                           gui=NONE guifg=#ffff00
hi LineNr       cterm=NONE ctermfg=Magenta
hi CursorLine   cterm=bold ctermfg=Black        ctermbg=White       gui=bold guifg=Magenta      guibg=White

hi DiffAdd      cterm=bold ctermfg=Yellow       ctermbg=Blue        gui=none guifg=Yellow       guibg=Blue
hi DiffDelete   cterm=bold ctermfg=Black        ctermbg=LightCyan   gui=none guifg=Black        guibg=LightCyan
hi DiffChange   cterm=bold ctermfg=Yellow       ctermbg=Magenta     gui=none guifg=Yellow       guibg=Magenta
hi DiffText     cterm=bold ctermfg=Yellow       ctermbg=Blue        gui=none guifg=Yellow       guibg=Blue
