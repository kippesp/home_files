-- kippes.lua: Retro green colorscheme based on Tokyo Night token mappings
-- Hue-shifted: blues→muted greens, purples→yellow-greens, black background
--
-- Workflow: edit palette below, then :source % to see changes live.
-- Use :Inspect on any token to see which capture group it belongs to.

local p = {
  -- Syntax: greens
  terminalgreen  = "#01bb05",
  boldgreen      = "#00ff13",
  green1         = "#87ea97",  -- functions, labels, calls
  green2         = "#3ccc60",  -- types, builtins, special
  palegreen      = "#98fb98",  -- operators, punctuation delimiters
  lightgreen     = "#90ee90",  -- preproc, macros, modules
  limegreen      = "#32cd32",
  lawngreen      = "#00ff13",
  brightlime     = "#5ce779",
  mediumseagreen = "#3cb371",
  brightseagreen = "#57cb87",
  yellow1        = "#cff0a1",  -- statements, conditionals, constructors
  yellow2        = "#b9d084",  -- keywords, return
  yellowgreen    = "#9acd32",

  -- Syntax: warm accents
  dirtygold       = "#f1bf52",
  mediumturquoise = "#4bd1cc",
  turquoise       = "#40e0d0",  -- strings
  lightsalmon    = "#ffa07a",
  burlywood      = "#e0af68",  -- parameters, string.doc
  lightcoral     = "#f7768e",  -- variable.builtin
  indianred      = "#cd5c5c",  -- errors
  darkaquamarine = "#1abc9c",  -- teal accents

  -- UI: foregrounds
  white          = "#ffffff",
  whitesmoke     = "#f5f5f5",
  fg             = "#9ab686",  -- Normal text (9.4:1 contrast)
  fg_dark        = "#819d6c",  -- dimmer text (7.0:1)
  lightolivegreen    = "#879d7b",  -- comments (7.1:1, office lighting)
  darkolivegreen     = "#556b2f",  -- line numbers
  paledarkolivegreen = "#5c7336",

  -- UI: backgrounds
  black           = "#000000",
  darkgreen1      = "#0a1a0a",  -- cursor line
  darkslategreen1 = "#1e321d",  -- visual selection
  darkslategreen2 = "#1a3a1a",  -- search highlight
  green5          = "#006400",  -- statusline
  darkgreen2      = "#002500",  -- inactive statusline
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "kippes"

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

------------------------------------------------------------
-- UI and Editor
------------------------------------------------------------
hl("Normal",       { fg = p.terminalgreen, bg = p.black })
hl("Cursor",       { fg = p.black, bg = p.terminalgreen })
hl("LineNr",       { fg = p.darkolivegreen })
hl("CursorLineNr", { fg = p.limegreen, bold = true })
hl("CursorLine",   { bg = p.darkgreen1 })
hl("StatusLine",   { fg = p.whitesmoke, bg = p.green5 })
hl("StatusLineNC", { fg = p.paledarkolivegreen, bg = p.darkgreen2 })
hl("Visual",       { bg = p.darkslategreen1 })
hl("VertSplit",    { fg = p.darkolivegreen })
hl("WinSeparator", { fg = p.darkolivegreen })
hl("Pmenu",        { fg = p.terminalgreen, bg = p.darkgreen1 })
hl("PmenuSel",     { fg = p.black, bg = p.green1 })
hl("Search",       { fg = p.black, bg = p.yellowgreen })
hl("IncSearch",    { fg = p.black, bg = p.dirtygold })
hl("ColorColumn",  { bg = p.darkgreen1 })
hl("SignColumn",   { fg = p.darkolivegreen })
hl("Folded",       { fg = p.darkolivegreen, bg = p.darkgreen1 })
hl("FoldColumn",   { fg = p.darkolivegreen })
hl("NonText",      { fg = p.darkolivegreen })
hl("MatchParen",   { fg = p.dirtygold, bold = true })
hl("Directory",    { fg = p.green1 })

------------------------------------------------------------
-- Classic syntax groups (fallback for tree-sitter linking)
------------------------------------------------------------
hl("Comment",      { fg = p.darkolivegreen, italic = true })
hl("Constant",     { fg = p.dirtygold })
hl("String",       { fg = p.turquoise })
hl("Character",    { fg = p.yellowgreen })
hl("Number",       { fg = p.dirtygold })
hl("Boolean",      { fg = p.dirtygold })
hl("Float",        { fg = p.dirtygold })
hl("Identifier",   { fg = p.yellow1 })
hl("Function",     { fg = p.green1 })
hl("Statement",    { fg = p.limegreen })
hl("Conditional",  { fg = p.limegreen })
hl("Repeat",       { fg = p.limegreen })
hl("Label",        { fg = p.green1 })
hl("Operator",     { fg = p.palegreen })
hl("Keyword",      { fg = p.yellow2 })
hl("Exception",    { fg = p.limegreen })
hl("PreProc",      { fg = p.lightgreen })
hl("Include",      { fg = p.lightgreen })
hl("Define",       { fg = p.lightgreen })
hl("Macro",        { fg = p.lightgreen })
hl("Type",         { fg = p.green2 })
hl("StorageClass", { fg = p.green2 })
hl("Structure",    { fg = p.green2 })
hl("Typedef",      { fg = p.green2 })
hl("Special",      { fg = p.green2 })
hl("Error",        { fg = p.indianred })
hl("Todo",         { fg = p.black, bg = p.burlywood })
hl("Underlined",   { underline = true })
hl("Title",        { fg = p.boldgreen, bold = true })

------------------------------------------------------------
-- Tree-sitter highlights (following Tokyo Night's mappings)
------------------------------------------------------------

-- Variables
hl("@variable",              { fg = p.terminalgreen })
hl("@variable.builtin",      { fg = p.lawngreen })               -- this
hl("@variable.parameter",    { fg = p.terminalgreen })
hl("@variable.member",       { fg = p.brightseagreen })               -- struct/class fields

-- Functions
hl("@function",              { fg = p.green1 })
hl("@function.builtin",      { fg = p.green2 })         -- static_assert, __builtin_*
hl("@function.call",         { fg = p.green1 })
hl("@function.macro",        { fg = p.lightgreen })
hl("@function.method",       { fg = p.green1 })
hl("@function.method.call",  { fg = p.green1 })
hl("@constructor",           { fg = p.yellow1 })

-- Keywords
hl("@keyword",               { fg = p.yellow2 })
hl("@keyword.conditional",   { fg = p.limegreen })
hl("@keyword.conditional.ternary", { fg = p.palegreen })
hl("@keyword.repeat",        { fg = p.limegreen })
hl("@keyword.return",        { fg = p.yellow2 })
hl("@keyword.exception",     { fg = p.limegreen })
hl("@keyword.operator",      { fg = p.palegreen })           -- new, delete, sizeof
hl("@keyword.type",          { fg = p.yellow2 })          -- class, struct, enum, namespace
hl("@keyword.modifier",      { fg = p.brightlime })          -- const, static, virtual, public
hl("@keyword.directive",     { fg = p.lightgreen })         -- #if, #ifdef
hl("@keyword.directive.define", { fg = p.lightgreen })      -- #define
hl("@keyword.import",        { fg = p.lightgreen })         -- #include
hl("@keyword.coroutine",     { fg = p.yellow2 })

-- Types
hl("@type",                  { fg = p.green2 })
hl("@type.builtin",          { fg = p.brightlime })
hl("@type.definition",       { fg = p.green2 })

-- Constants
hl("@constant",              { fg = p.dirtygold })
hl("@constant.builtin",      { fg = p.green2 })         -- nullptr, NULL
hl("@constant.macro",        { fg = p.lightgreen })         -- #define NAME

-- Strings
hl("@string",                { fg = p.turquoise })
hl("@string.escape",         { fg = p.yellow1 })
hl("@string.documentation",  { fg = p.burlywood })

-- Modules (namespaces)
hl("@module",                { fg = p.lightgreen })         -- std::

-- Properties
hl("@property",              { fg = p.brightseagreen })

-- Misc
hl("@attribute",             { fg = p.lightgreen })
hl("@label",                 { fg = p.green1 })
hl("@operator",              { fg = p.palegreen })
hl("@punctuation.bracket",   { fg = p.fg_dark })
hl("@punctuation.delimiter", { fg = p.palegreen })
hl("@punctuation.special",   { fg = p.palegreen })
hl("@comment",               { fg = p.darkolivegreen, italic = true })
hl("@comment.documentation", { fg = p.darkolivegreen, italic = true })

-- Numbers/booleans (explicit to ensure orange)
hl("@number",                { fg = p.dirtygold })
hl("@number.float",          { fg = p.dirtygold })
hl("@boolean",               { fg = p.dirtygold })
hl("@character",             { fg = p.yellowgreen })

------------------------------------------------------------
-- Diagnostics
------------------------------------------------------------
hl("DiagnosticError",          { fg = p.indianred })
hl("DiagnosticWarn",           { fg = p.burlywood })
hl("DiagnosticInfo",           { fg = p.brightseagreen })
hl("DiagnosticHint",           { fg = p.brightseagreen })
hl("DiagnosticUnderlineError", { undercurl = true, sp = p.indianred })
hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = p.burlywood })
hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = p.brightseagreen })
hl("DiagnosticUnderlineHint",  { undercurl = true, sp = p.brightseagreen })
