" vim:fdm=marker
" Vim Color File
" Name:       kippes.vim
" License:    The MIT License (MIT)

" Initialization {{{

highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

" Enable italic support in terminals
if !has('gui_running')
  let &t_ZH="\033[3m"
  let &t_ZR="\033[23m"
endif

let g:colors_name="kippes"

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
" (a 16-color palette for this color scheme is available; see
" < https://github.com/joshdick/onedark.vim/blob/main/README.md >
" for more information.)
if !exists("g:kippes_termcolors")
  let g:kippes_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:kippes_terminal_italics")
  let g:kippes_terminal_italics = 0
endif

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
let s:group_colors = {} " Cache of default highlight group settings, for later reference via `kippes#extend_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from onedark#extend_highlight
    let s:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(s:highlight, style_type) ? copy(s:highlight[style_type]) : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let s:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let s:highlight.gui = a:style.gui
    endif
    if (has_key(a:style, "cterm"))
      let s:highlight.cterm = a:style.cterm
    endif
  else
    let s:highlight = a:style
    let s:group_colors[a:group] = s:highlight " Cache default highlight group settings
  endif

  if g:kippes_terminal_italics == 0
    if has_key(s:highlight, "cterm") && s:highlight["cterm"] == "italic"
      unlet s:highlight.cterm
    endif
    if has_key(s:highlight, "gui") && s:highlight["gui"] == "italic"
      unlet s:highlight.gui
    endif
  endif

  if g:kippes_termcolors == 16
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm : "NONE")
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(s:highlight, "fg")    ? s:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(s:highlight, "bg")    ? s:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(s:highlight, "sp")    ? s:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(s:highlight, "gui")   ? s:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(s:highlight, "cterm") ? s:highlight.cterm    : "NONE")
endfunction

" public {{{

function! kippes#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction

function! kippes#extend_highlight(group, style)
  call s:h(a:group, a:style, 1)
endfunction

" }}}

" }}}

" Color Variables {{{

let s:colors = kippes#GetColors()

let s:red = s:colors.red
let s:dark_red = s:colors.dark_red
let s:green = s:colors.green
let s:yellow = s:colors.yellow
let s:butter = s:colors.butter
let s:golden_delicious = s:colors.golden_delicious
let s:yew = s:colors.yew
let s:dark_yellow = s:colors.dark_yellow
let s:blue = s:colors.blue
let s:purple = s:colors.purple
let s:cyan = s:colors.cyan
let s:white = s:colors.white
let s:black = s:colors.black
let s:background = s:colors.background
let s:thunder = s:colors.thunder
let s:cursor_grey = s:colors.cursor_grey
let s:special_grey = s:colors.special_grey
let s:status_white = s:colors.status_white
let s:dark_green = s:colors.dark_green
let s:column_dark_red = s:colors.column_dark_red
let s:digital = s:colors.digital
let s:dark_tone_ink = s:colors.dark_tone_ink
let s:bright_cyan = s:colors.bright_cyan
let s:plunge_pool = s:colors.plunge_pool
let s:bright_yellow = s:colors.bright_yellow
let s:bold_bright_green = s:colors.bold_bright_green
let s:bright_orange = s:colors.bright_orange
let s:bright_red = s:colors.bright_red
let s:azure = s:colors.azure
let s:blue_cola = s:colors.blue_cola
let s:terminal_green = s:colors.terminal_green
let s:background_green = s:colors.background_green

" }}}

" Terminal Colors {{{

if !has('nvim')
  let g:terminal_ansi_colors = [
    \ s:black.gui, s:red.gui, s:green.gui, s:yellow.gui,
    \ s:blue.gui, s:purple.gui, s:cyan.gui, s:white.gui,
    \ s:thunder.gui, s:dark_red.gui, s:green.gui, s:dark_yellow.gui,
    \ s:blue.gui, s:purple.gui, s:cyan.gui, s:thunder.gui
  \]
endif

" }}}

" Syntax Groups (descriptions and ordering from `:h w18`) {{{

call s:h("Comment", { "fg": s:dark_green, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:cyan }) " any constant
call s:h("String", { "fg": s:bright_cyan }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:yellow }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:yellow }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:yellow }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:bold_bright_green, "gui": "bold", "cterm": "bold" }) " any variable name
call s:h("Function", { "fg": s:blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:bold_bright_green, "gui": "bold", "cterm": "bold" }) " any statement
call s:h("Conditional", { "fg": s:bold_bright_green, "gui": "bold", "cterm": "bold" }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:bold_bright_green, "gui": "bold", "cterm": "bold" }) " for, do, while, etc.
call s:h("Label", { "fg": s:bold_bright_green, "gui": "bold", "cterm": "bold" }) " case, default, etc.
call s:h("Operator", { "fg": s:bright_yellow }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:yellow }) " any other keyword
call s:h("Exception", { "fg": s:bold_bright_green, "gui": "bold", "cterm": "bold" }) " try, catch, throw
call s:h("PreProc", { "fg": s:yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:blue }) " preprocessor #include
call s:h("Define", { "fg": s:purple }) " preprocessor #define
call s:h("Macro", { "fg": s:purple }) " same as Define
call s:h("PreCondit", { "fg": s:yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:golden_delicious }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:golden_delicious }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:yellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:yellow }) " A typedef
call s:h("Special", { "fg": s:blue }) " any special symbol
call s:h("SpecialChar", { "fg": s:bright_yellow }) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:terminal_green, "bg": s:background_green }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:red }) " any erroneous construct
call s:h("Todo", { "fg": s:purple }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX
call s:h("TrailingWhitespace", { "bg": s:red }) " trailing whitespace

" }}}

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`) {{{
call s:h("ColorColumn", { "bg": s:column_dark_red }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:black, "bg": s:blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
  " Don't change the background color in diff mode
  call s:h("CursorLine", { "gui": "underline" }) " the screen line that the cursor is in when 'cursorline' is set
else
  call s:h("CursorLine", { "bg": s:cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:green, "fg": s:black }) " diff mode: Added line
call s:h("DiffChange", { "fg": s:yellow, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:red, "fg": s:black }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:yellow, "fg": s:black }) " diff mode: Changed text within a changed line
if get(g:, 'kippes_hide_endofbuffer', 0)
    " If enabled, will style end-of-buffer filler lines (~) to appear to be hidden.
    call s:h("EndOfBuffer", { "fg": s:black }) " filler lines (~) after the last line in the buffer
endif
call s:h("ErrorMsg", { "fg": s:red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:thunder }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:thunder }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:yellow, "bg": s:thunder }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:digital, "bg": s:dark_tone_ink }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:blue, "gui": "underline", "cterm": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:green, "bg": s:background }) " normal text
call s:h("Pmenu", { "fg": s:white, "bg": s:thunder }) " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:cursor_grey, "bg": s:blue }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:cursor_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:purple }) " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow }) " Current quickfix item in the quickfix window.
call s:h("Search", { "fg": s:black, "bg": s:yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:dark_yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:status_white, "bg": s:dark_green }) " status line of current window
call s:h("StatusLineNC", { "fg": s:thunder, "bg": s:background_green }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("StatusLineTerm", { "fg": s:white, "bg": s:cursor_grey }) " status line of current :terminal window
call s:h("StatusLineTermNC", { "fg": s:thunder, "bg": s:background_green }) " status line of non-current :terminal window
call s:h("TabLine", { "fg": s:thunder }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white }) " tab pages line, active tab page label
call s:h("Terminal", { "fg": s:white, "bg": s:black }) " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "bg": s:thunder }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:thunder }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:yellow }) " warning messages
call s:h("WildMenu", { "fg": s:black, "bg": s:blue }) " current match in 'wildmenu' completion

" }}}

" Termdebug highlighting for Vim 8.1+ {{{

" See `:h hl-debugPC` and `:h hl-debugBreakpoint`.
call s:h("debugPC", { "bg": s:special_grey }) " the current position
call s:h("debugBreakpoint", { "fg": s:black, "bg": s:red }) " a breakpoint

" }}}

" Language-Specific Highlighting {{{

" CSS
call s:h("cssAttrComma", { "fg": s:purple })
call s:h("cssAttributeSelector", { "fg": s:green })
call s:h("cssBraces", { "fg": s:white })
call s:h("cssClassName", { "fg": s:dark_yellow })
call s:h("cssClassNameDot", { "fg": s:dark_yellow })
call s:h("cssDefinition", { "fg": s:purple })
call s:h("cssFontAttr", { "fg": s:dark_yellow })
call s:h("cssFontDescriptor", { "fg": s:purple })
call s:h("cssFunctionName", { "fg": s:blue })
call s:h("cssIdentifier", { "fg": s:blue })
call s:h("cssImportant", { "fg": s:purple })
call s:h("cssInclude", { "fg": s:white })
call s:h("cssIncludeKeyword", { "fg": s:purple })
call s:h("cssMediaType", { "fg": s:dark_yellow })
call s:h("cssProp", { "fg": s:white })
call s:h("cssPseudoClassId", { "fg": s:dark_yellow })
call s:h("cssSelectorOp", { "fg": s:purple })
call s:h("cssSelectorOp2", { "fg": s:purple })
call s:h("cssTagName", { "fg": s:red })

" Fish Shell
call s:h("fishKeyword", { "fg": s:purple })
call s:h("fishConditional", { "fg": s:purple })

" Go
call s:h("goDeclaration", { "fg": s:purple })
call s:h("goBuiltins", { "fg": s:cyan })
call s:h("goFunctionCall", { "fg": s:blue })
call s:h("goVarDefs", { "fg": s:red })
call s:h("goVarAssign", { "fg": s:red })
call s:h("goVar", { "fg": s:purple })
call s:h("goConst", { "fg": s:purple })
call s:h("goType", { "fg": s:yellow })
call s:h("goTypeName", { "fg": s:yellow })
call s:h("goDeclType", { "fg": s:cyan })
call s:h("goTypeDecl", { "fg": s:purple })

" HTML (keep consistent with Markdown, below)
call s:h("htmlArg", { "fg": s:dark_yellow })
call s:h("htmlBold", { "fg": s:dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("htmlBoldItalic", { "fg": s:green, "gui": "bold,italic", "cterm": "bold,italic" })
call s:h("htmlEndTag", { "fg": s:white })
call s:h("htmlH1", { "fg": s:red })
call s:h("htmlH2", { "fg": s:red })
call s:h("htmlH3", { "fg": s:red })
call s:h("htmlH4", { "fg": s:red })
call s:h("htmlH5", { "fg": s:red })
call s:h("htmlH6", { "fg": s:red })
call s:h("htmlItalic", { "fg": s:purple, "gui": "italic", "cterm": "italic" })
call s:h("htmlLink", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })
call s:h("htmlSpecialChar", { "fg": s:dark_yellow })
call s:h("htmlSpecialTagName", { "fg": s:red })
call s:h("htmlTag", { "fg": s:white })
call s:h("htmlTagN", { "fg": s:red })
call s:h("htmlTagName", { "fg": s:red })
call s:h("htmlTitle", { "fg": s:white })

" JavaScript
call s:h("javaScriptBraces", { "fg": s:white })
call s:h("javaScriptFunction", { "fg": s:purple })
call s:h("javaScriptIdentifier", { "fg": s:purple })
call s:h("javaScriptNull", { "fg": s:dark_yellow })
call s:h("javaScriptNumber", { "fg": s:dark_yellow })
call s:h("javaScriptRequire", { "fg": s:cyan })
call s:h("javaScriptReserved", { "fg": s:purple })
" https://github.com/pangloss/vim-javascript
call s:h("jsArrowFunction", { "fg": s:purple })
call s:h("jsClassKeyword", { "fg": s:purple })
call s:h("jsClassMethodType", { "fg": s:purple })
call s:h("jsDocParam", { "fg": s:blue })
call s:h("jsDocTags", { "fg": s:purple })
call s:h("jsExport", { "fg": s:purple })
call s:h("jsExportDefault", { "fg": s:purple })
call s:h("jsExtendsKeyword", { "fg": s:purple })
call s:h("jsFrom", { "fg": s:purple })
call s:h("jsFuncCall", { "fg": s:blue })
call s:h("jsFunction", { "fg": s:purple })
call s:h("jsGenerator", { "fg": s:yellow })
call s:h("jsGlobalObjects", { "fg": s:yellow })
call s:h("jsImport", { "fg": s:purple })
call s:h("jsModuleAs", { "fg": s:purple })
call s:h("jsModuleWords", { "fg": s:purple })
call s:h("jsModules", { "fg": s:purple })
call s:h("jsNull", { "fg": s:dark_yellow })
call s:h("jsOperator", { "fg": s:purple })
call s:h("jsStorageClass", { "fg": s:purple })
call s:h("jsSuper", { "fg": s:red })
call s:h("jsTemplateBraces", { "fg": s:dark_red })
call s:h("jsTemplateVar", { "fg": s:green })
call s:h("jsThis", { "fg": s:red })
call s:h("jsUndefined", { "fg": s:dark_yellow })
" https://github.com/othree/yajs.vim
call s:h("javascriptArrowFunc", { "fg": s:purple })
call s:h("javascriptClassExtends", { "fg": s:purple })
call s:h("javascriptClassKeyword", { "fg": s:purple })
call s:h("javascriptDocNotation", { "fg": s:purple })
call s:h("javascriptDocParamName", { "fg": s:blue })
call s:h("javascriptDocTags", { "fg": s:purple })
call s:h("javascriptEndColons", { "fg": s:white })
call s:h("javascriptExport", { "fg": s:purple })
call s:h("javascriptFuncArg", { "fg": s:white })
call s:h("javascriptFuncKeyword", { "fg": s:purple })
call s:h("javascriptIdentifier", { "fg": s:red })
call s:h("javascriptImport", { "fg": s:purple })
call s:h("javascriptMethodName", { "fg": s:white })
call s:h("javascriptObjectLabel", { "fg": s:white })
call s:h("javascriptOpSymbol", { "fg": s:cyan })
call s:h("javascriptOpSymbols", { "fg": s:cyan })
call s:h("javascriptPropertyName", { "fg": s:green })
call s:h("javascriptTemplateSB", { "fg": s:dark_red })
call s:h("javascriptVariable", { "fg": s:purple })

" JSON
call s:h("jsonCommentError", { "fg": s:white })
call s:h("jsonKeyword", { "fg": s:red })
call s:h("jsonBoolean", { "fg": s:dark_yellow })
call s:h("jsonNumber", { "fg": s:dark_yellow })
call s:h("jsonQuote", { "fg": s:white })
call s:h("jsonMissingCommaError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNoQuotesError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNumError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonString", { "fg": s:green })
call s:h("jsonStringSQError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonSemicolonError", { "fg": s:red, "gui": "reverse" })

" LESS
call s:h("lessVariable", { "fg": s:purple })
call s:h("lessAmpersandChar", { "fg": s:white })
call s:h("lessClass", { "fg": s:dark_yellow })

" Markdown (keep consistent with HTML, above)
call s:h("markdownBlockquote", { "fg": s:dark_green })
call s:h("markdownBold", { "fg": s:bold_bright_green, "gui": "bold", "cterm": "bold" })
call s:h("markdownBoldItalic", { "fg": s:bright_cyan, "gui": "bold,italic", "cterm": "bold,italic" })
call s:h("markdownCode", { "fg": s:blue })
call s:h("markdownCodeBlock", { "fg": s:blue })
call s:h("markdownCodeDelimiter", { "fg": s:blue })
call s:h("markdownH1", { "fg": s:butter })
call s:h("markdownH2", { "fg": s:golden_delicious })
call s:h("markdownH3", { "fg": s:yew })
call s:h("markdownH4", { "fg": s:yew })
call s:h("markdownH5", { "fg": s:yew })
call s:h("markdownH6", { "fg": s:yew })
call s:h("markdownHeadingDelimiter", { "fg": s:butter })
call s:h("markdownHeadingRule", { "fg": s:thunder })
call s:h("markdownId", { "fg": s:purple })
call s:h("markdownIdDeclaration", { "fg": s:blue })
call s:h("markdownIdDelimiter", { "fg": s:purple })
call s:h("markdownItalic", { "fg": s:bright_cyan, "gui": "italic", "cterm": "italic" })
call s:h("markdownLinkDelimiter", { "fg": s:bold_bright_green })
call s:h("markdownLinkText", { "fg": s:azure })
call s:h("markdownListMarker", { "fg": s:green })
call s:h("markdownOrderedListMarker", { "fg": s:green })
call s:h("markdownRule", { "fg": s:dark_green })
call s:h("markdownUrl", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" Perl
call s:h("perlFiledescRead", { "fg": s:green })
call s:h("perlFunction", { "fg": s:purple })
call s:h("perlMatchStartEnd",{ "fg": s:blue })
call s:h("perlMethod", { "fg": s:purple })
call s:h("perlPOD", { "fg": s:thunder })
call s:h("perlSharpBang", { "fg": s:thunder })
call s:h("perlSpecialString",{ "fg": s:dark_yellow })
call s:h("perlStatementFiledesc", { "fg": s:red })
call s:h("perlStatementFlow",{ "fg": s:red })
call s:h("perlStatementInclude", { "fg": s:purple })
call s:h("perlStatementScalar",{ "fg": s:purple })
call s:h("perlStatementStorage", { "fg": s:purple })
call s:h("perlSubName",{ "fg": s:yellow })
call s:h("perlVarPlain",{ "fg": s:blue })

" PHP
call s:h("phpVarSelector", { "fg": s:red })
call s:h("phpOperator", { "fg": s:white })
call s:h("phpParent", { "fg": s:white })
call s:h("phpMemberSelector", { "fg": s:white })
call s:h("phpType", { "fg": s:purple })
call s:h("phpKeyword", { "fg": s:purple })
call s:h("phpClass", { "fg": s:yellow })
call s:h("phpUseClass", { "fg": s:white })
call s:h("phpUseAlias", { "fg": s:white })
call s:h("phpInclude", { "fg": s:purple })
call s:h("phpClassExtends", { "fg": s:green })
call s:h("phpDocTags", { "fg": s:white })
call s:h("phpFunction", { "fg": s:blue })
call s:h("phpFunctions", { "fg": s:cyan })
call s:h("phpMethodsVar", { "fg": s:dark_yellow })
call s:h("phpMagicConstants", { "fg": s:dark_yellow })
call s:h("phpSuperglobals", { "fg": s:red })
call s:h("phpConstants", { "fg": s:dark_yellow })

" Ruby
call s:h("rubyBlockParameter", { "fg": s:red})
call s:h("rubyBlockParameterList", { "fg": s:red })
call s:h("rubyClass", { "fg": s:purple})
call s:h("rubyConstant", { "fg": s:yellow})
call s:h("rubyControl", { "fg": s:purple })
call s:h("rubyEscape", { "fg": s:red})
call s:h("rubyFunction", { "fg": s:blue})
call s:h("rubyGlobalVariable", { "fg": s:red})
call s:h("rubyInclude", { "fg": s:blue})
call s:h("rubyIncluderubyGlobalVariable", { "fg": s:red})
call s:h("rubyInstanceVariable", { "fg": s:red})
call s:h("rubyInterpolation", { "fg": s:cyan })
call s:h("rubyInterpolationDelimiter", { "fg": s:red })
call s:h("rubyInterpolationDelimiter", { "fg": s:red})
call s:h("rubyRegexp", { "fg": s:cyan})
call s:h("rubyRegexpDelimiter", { "fg": s:cyan})
call s:h("rubyStringDelimiter", { "fg": s:green})
call s:h("rubySymbol", { "fg": s:cyan})

" Sass
" https://github.com/tpope/vim-haml
call s:h("sassAmpersand", { "fg": s:red })
call s:h("sassClass", { "fg": s:dark_yellow })
call s:h("sassControl", { "fg": s:purple })
call s:h("sassExtend", { "fg": s:purple })
call s:h("sassFor", { "fg": s:white })
call s:h("sassFunction", { "fg": s:cyan })
call s:h("sassId", { "fg": s:blue })
call s:h("sassInclude", { "fg": s:purple })
call s:h("sassMedia", { "fg": s:purple })
call s:h("sassMediaOperators", { "fg": s:white })
call s:h("sassMixin", { "fg": s:purple })
call s:h("sassMixinName", { "fg": s:blue })
call s:h("sassMixing", { "fg": s:purple })
call s:h("sassVariable", { "fg": s:purple })
" https://github.com/cakebaker/scss-syntax.vim
call s:h("scssExtend", { "fg": s:purple })
call s:h("scssImport", { "fg": s:purple })
call s:h("scssInclude", { "fg": s:purple })
call s:h("scssMixin", { "fg": s:purple })
call s:h("scssSelectorName", { "fg": s:dark_yellow })
call s:h("scssVariable", { "fg": s:purple })

" TeX
call s:h("texStatement", { "fg": s:purple })
call s:h("texSubscripts", { "fg": s:dark_yellow })
call s:h("texSuperscripts", { "fg": s:dark_yellow })
call s:h("texTodo", { "fg": s:dark_red })
call s:h("texBeginEnd", { "fg": s:purple })
call s:h("texBeginEndName", { "fg": s:blue })
call s:h("texMathMatcher", { "fg": s:blue })
call s:h("texMathDelim", { "fg": s:blue })
call s:h("texDelimiter", { "fg": s:dark_yellow })
call s:h("texSpecialChar", { "fg": s:dark_yellow })
call s:h("texCite", { "fg": s:blue })
call s:h("texRefZone", { "fg": s:blue })

" TypeScript
call s:h("typescriptReserved", { "fg": s:purple })
call s:h("typescriptEndColons", { "fg": s:white })
call s:h("typescriptBraces", { "fg": s:white })

" XML
call s:h("xmlAttrib", { "fg": s:dark_yellow })
call s:h("xmlEndTag", { "fg": s:red })
call s:h("xmlTag", { "fg": s:red })
call s:h("xmlTagName", { "fg": s:red })

" }}}

" Plugin Highlighting {{{

" airblade/vim-gitgutter
call s:h("GitGutterAdd", { "fg": s:green })
call s:h("GitGutterChange", { "fg": s:yellow })
call s:h("GitGutterDelete", { "fg": s:red })

" dense-analysis/ale
call s:h("ALEError", { "fg": s:red, "gui": "underline", "cterm": "underline" })
call s:h("ALEWarning", { "fg": s:yellow, "gui": "underline", "cterm": "underline" })
call s:h("ALEInfo", { "gui": "underline", "cterm": "underline" })
call s:h("ALEErrorSign", { "fg": s:red })
call s:h("ALEWarningSign", { "fg": s:yellow })
call s:h("ALEInfoSign", { })

" easymotion/vim-easymotion
call s:h("EasyMotionTarget", { "fg": s:red, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2First", { "fg": s:yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2Second", { "fg": s:dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionShade",  { "fg": s:thunder })

" lewis6991/gitsigns.nvim
hi link GitSignsAdd    GitGutterAdd
hi link GitSignsChange GitGutterChange
hi link GitSignsDelete GitGutterDelete

" mhinz/vim-signify
hi link SignifySignAdd    GitGutterAdd
hi link SignifySignChange GitGutterChange
hi link SignifySignDelete GitGutterDelete

" neoclide/coc.nvim
call s:h("CocErrorSign", { "fg": s:red })
call s:h("CocWarningSign", { "fg": s:yellow })
call s:h("CocInfoSign", { "fg": s:blue })
call s:h("CocHintSign", { "fg": s:cyan })
call s:h("CocFadeOut", { "fg": s:thunder })
" https://github.com/joshdick/onedark.vim/issues/313
highlight! link CocMenuSel PmenuSel

" neomake/neomake
call s:h("NeomakeErrorSign", { "fg": s:red })
call s:h("NeomakeWarningSign", { "fg": s:yellow })
call s:h("NeomakeInfoSign", { "fg": s:blue })

" plasticboy/vim-markdown (keep consistent with Markdown, above)
call s:h("mkdDelimiter", { "fg": s:purple })
call s:h("mkdHeading", { "fg": s:red })
call s:h("mkdLink", { "fg": s:blue })
call s:h("mkdURL", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" prabirshrestha/vim-lsp
call s:h("LspErrorText", { "fg": s:red })
call s:h("LspWarningText", { "fg": s:yellow })
call s:h("LspInformationText", { "fg":s:blue })
call s:h("LspHintText", { "fg":s:cyan })
call s:h("LspErrorHighlight", { "fg": s:red, "gui": "underline", "cterm": "underline" })
call s:h("LspWarningHighlight", { "fg": s:yellow, "gui": "underline", "cterm": "underline" })
call s:h("LspInformationHighlight", { "fg":s:blue, "gui": "underline", "cterm": "underline" })
call s:h("LspHintHighlight", { "fg":s:cyan, "gui": "underline", "cterm": "underline" })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:green })
call s:h("diffRemoved", { "fg": s:red })

" }}}

" Git Highlighting {{{

call s:h("gitcommitComment", { "fg": s:thunder })
call s:h("gitcommitUnmerged", { "fg": s:green })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:purple })
call s:h("gitcommitDiscardedType", { "fg": s:red })
call s:h("gitcommitSelectedType", { "fg": s:green })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:cyan })
call s:h("gitcommitDiscardedFile", { "fg": s:red })
call s:h("gitcommitSelectedFile", { "fg": s:green })
call s:h("gitcommitUnmergedFile", { "fg": s:yellow })
call s:h("gitcommitFile", {})
call s:h("gitcommitSummary", { "fg": s:white })
call s:h("gitcommitOverflow", { "fg": s:red })
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile

" }}}


" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
