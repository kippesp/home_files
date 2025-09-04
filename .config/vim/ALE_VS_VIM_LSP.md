# ALE vs vim-lsp: Vim Plugin Comparison

## Overview
Comparison of two popular approaches for adding modern development features to Vim:
- **ALE** (Asynchronous Lint Engine) - Traditional linter integration
- **vim-lsp** - Language Server Protocol client

## What They Solve
Both plugins address the same core problem: Vim lacks built-in error checking, code completion, and IDE-like features that modern editors provide. Neovim has these built-in, but regular Vim needs plugins.

## ALE (Asynchronous Lint Engine)

### Philosophy
- **Linter-based approach** - Uses existing command-line tools
- **Language agnostic** - Works with any linter that outputs text
- **Vim-centric** - Designed specifically for Vim's workflow

### Features
- **Real-time error checking** as you type
- **Syntax highlighting** for errors/warnings  
- **Auto-fixing** - Can run fixers like `eslint --fix`, `gofmt`, etc.
- **300+ linters supported** - eslint, pylint, shellcheck, rubocop, etc.
- **Sign column indicators** - Shows error/warning symbols in gutter
- **Statusline integration** - Error counts in status bar
- **Jump to errors** - Navigate between problems
- **Highly configurable** - Fine-tune which linters run when

### Installation
```vim
" Using vim-plug
Plug 'dense-analysis/ale'

" Manual
cd ~/.vim/pack/plugins/start/
git clone https://github.com/dense-analysis/ale.git
```

### Basic Configuration
```vim
" Enable ALE
let g:ale_enabled = 1

" Show errors in sign column
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '▲'

" Lint on text change (default), save, and when opening files
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1

" Auto-fix on save
let g:ale_fix_on_save = 1

" Configure linters per filetype
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['pylint', 'flake8'],
\   'c': ['gcc', 'clang'],
\   'cpp': ['gcc', 'clang'],
\   'sh': ['shellcheck'],
\}

" Configure fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['black', 'isort'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\}

" Navigation keybindings
nmap [g <Plug>(ale_previous_wrap)
nmap ]g <Plug>(ale_next_wrap)
```

### Pros
- **Simple setup** - Just install and it works
- **Broad language support** - 300+ linters
- **Fast** - Runs linters asynchronously
- **Familiar tools** - Uses linters you already know
- **Auto-fixing** - Can automatically fix many issues
- **Lightweight** - Doesn't require language servers

### Cons  
- **Limited intelligence** - Only syntax/style checking, no semantic analysis
- **No code completion** - Doesn't provide auto-complete
- **No navigation** - Can't go-to-definition or find references
- **Tool dependency** - Requires external linters to be installed

## vim-lsp (Language Server Protocol)

### Philosophy
- **LSP-based approach** - Uses Language Server Protocol
- **Semantic understanding** - Full language comprehension
- **IDE-like features** - Brings VS Code-style functionality to Vim

### Features
- **Intelligent code completion** - Context-aware suggestions
- **Go-to-definition** - Jump to symbol definitions
- **Find references** - Show all uses of a symbol
- **Rename refactoring** - Rename symbols across project
- **Hover documentation** - Show docs on hover
- **Real-time error checking** - Compiler-level diagnostics
- **Semantic highlighting** - Colors based on code meaning
- **Symbol search** - Find symbols in workspace
- **Signature help** - Function parameter hints

### Installation
```vim
" Using vim-plug
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'           " For completion
Plug 'prabirshrestha/asyncomplete-lsp.vim'       " LSP completion source

" Manual
cd ~/.vim/pack/plugins/start/
git clone https://github.com/prabirshrestha/vim-lsp.git
git clone https://github.com/prabirshrestha/asyncomplete.vim.git
git clone https://github.com/prabirshrestha/asyncomplete-lsp.vim.git
```

### Configuration Example (Python)
```vim
" Register Python LSP server (requires: pip install python-lsp-server)
if executable('pylsp')
    augroup lsp_python
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pylsp',
            \ 'cmd': {server_info->['pylsp']},
            \ 'whitelist': ['python'],
            \ 'workspace_config': {
            \   'pylsp': {
            \     'plugins': {
            \       'pycodestyle': {'enabled': v:true},
            \       'pylint': {'enabled': v:true},
            \     }
            \   }
            \ }
        \ })
        
        " Key bindings for Python files
        autocmd FileType python setlocal omnifunc=lsp#complete
        autocmd FileType python nmap <buffer> gd <plug>(lsp-definition)
        autocmd FileType python nmap <buffer> gr <plug>(lsp-references) 
        autocmd FileType python nmap <buffer> gi <plug>(lsp-implementation)
        autocmd FileType python nmap <buffer> gt <plug>(lsp-type-definition)
        autocmd FileType python nmap <buffer> <leader>rn <plug>(lsp-rename)
        autocmd FileType python nmap <buffer> [g <plug>(lsp-previous-diagnostic)
        autocmd FileType python nmap <buffer> ]g <plug>(lsp-next-diagnostic)
        autocmd FileType python nmap <buffer> K <plug>(lsp-hover)
    augroup END
endif

" Global LSP settings
let g:lsp_semantic_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
```

### Language Server Requirements
Each language needs its own server installed:

| Language | Server | Install Command |
|----------|--------|-----------------|
| Python | pylsp | `pip install python-lsp-server` |
| JavaScript/TypeScript | typescript-language-server | `npm install -g typescript-language-server` |
| C/C++ | clangd | `brew install llvm` (macOS) |
| Rust | rust-analyzer | `rustup component add rust-analyzer` |
| Go | gopls | `go install golang.org/x/tools/gopls@latest` |
| Java | jdtls | Download Eclipse JDT LS |

### Pros
- **Full IDE features** - Completion, navigation, refactoring
- **Semantic understanding** - Knows code meaning, not just syntax
- **Standardized** - LSP is an open standard
- **Rich diagnostics** - Compiler-level error checking
- **Cross-editor** - Same servers work in VS Code, Neovim, etc.
- **Project-aware** - Understands imports, dependencies, etc.

### Cons
- **Complex setup** - Each language needs its own server
- **Resource intensive** - Language servers can use significant memory
- **External dependencies** - Requires language servers to be installed
- **Learning curve** - More configuration needed
- **Language limitations** - Not all languages have good LSP servers

## Side-by-Side Comparison

| Feature | ALE | vim-lsp |
|---------|-----|---------|
| **Error Checking** | ✅ Via linters | ✅ Via LSP servers |
| **Auto-completion** | ❌ No | ✅ Intelligent completion |
| **Go-to-definition** | ❌ No | ✅ Yes |
| **Find references** | ❌ No | ✅ Yes |
| **Rename refactoring** | ❌ No | ✅ Yes |
| **Auto-fixing** | ✅ Many fixers | ✅ Some servers support |
| **Setup complexity** | 🟢 Simple | 🟡 Moderate |
| **Resource usage** | 🟢 Light | 🟡 Heavy |
| **Language support** | 🟢 300+ linters | 🟡 Server dependent |
| **Semantic highlighting** | ❌ No | ✅ Yes |
| **Project understanding** | ❌ File-level only | ✅ Full project |

## Hybrid Approach: Using Both

You can use both plugins together for maximum functionality:

```vim
" Install both
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Configure ALE for fixing only
let g:ale_linters_explicit = 1  " Only use explicitly configured linters
let g:ale_linters = {}          " Disable all linters (let LSP handle diagnostics)
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['black', 'isort'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\}
let g:ale_fix_on_save = 1

" Use vim-lsp for diagnostics and IDE features
let g:lsp_diagnostics_enabled = 1
" ... rest of vim-lsp config
```

## Recommendation for Your Setup

Based on your CLANGD_LSP_SETUP.md, you're already using **vim-lsp** with clangd for C++. Here's my recommendation:

### For C/C++ Development
- **Stick with vim-lsp + clangd** - You get semantic highlighting that works with your kippes color scheme
- **Add ALE for auto-formatting** - Use it just for `clang-format` on save

### For Other Languages
- **vim-lsp** if the language has a good LSP server (Python, JavaScript, Rust, Go)
- **ALE** for languages with great linters but poor LSP support (shell scripts, older languages)

### Quick Start Configuration
```vim
" ALE for formatting only
let g:ale_linters = {}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'python': ['black'],
\   'sh': ['shfmt'],
\}
let g:ale_fix_on_save = 1

" vim-lsp for intelligence (you already have clangd setup)
" Add Python LSP:
if executable('pylsp')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'whitelist': ['python'],
    \ })
endif
```

This gives you the best of both worlds: intelligent IDE features from LSP and reliable auto-fixing from ALE.

## Integration with Your kippes Color Scheme

Both plugins will use your color scheme's diagnostic highlighting:

### ALE Signs
- Uses `ALEErrorSign`, `ALEWarningSign` highlight groups
- Falls back to `Error`, `Warning` if not defined

### vim-lsp Diagnostics  
- Uses `LspErrorText`, `LspWarningText` highlight groups
- Falls back to standard Vim diagnostic colors

Since you removed Neovim-specific highlighting, both plugins will use Vim's standard error/warning colors, which should integrate well with your kippes theme.