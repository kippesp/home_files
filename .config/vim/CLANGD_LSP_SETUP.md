# Clangd + LSP Setup for Vim

## Overview
Setting up clangd (LLVM's language server) with vim-lsp for better C++ syntax highlighting, code completion, and semantic analysis.

## Benefits
- **Semantic highlighting** - variables/types get proper colors based on actual code analysis
- **Intelligent code completion** - context-aware suggestions  
- **Go-to-definition** - jump to function/variable definitions
- **Error checking** - real-time compiler errors/warnings
- **Cross-platform** - works on Windows, macOS, Linux

## Installation

### Step 1: Install clangd

**macOS (using Homebrew):**
```bash
brew install llvm
# clangd will be at /opt/homebrew/bin/clangd (Apple Silicon) or /usr/local/bin/clangd (Intel)
```

**Windows:**
```bash
# Option 1: Chocolatey
choco install llvm

# Option 2: Download LLVM from https://releases.llvm.org/
# Add to PATH: C:\Program Files\LLVM\bin
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt install clangd-12  # or latest version
```

### Step 2: Install vim-lsp Plugin

**Using vim-plug (add to vimrc):**
```vim
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
```

**Manual installation:**
```bash
cd ~/.vim/pack/plugins/start/
git clone https://github.com/prabirshrestha/vim-lsp.git
git clone https://github.com/prabirshrestha/asyncomplete.vim.git
git clone https://github.com/prabirshrestha/asyncomplete-lsp.vim.git
```

### Step 3: Configure vim-lsp

**Add to your vimrc:**
```vim
" Register clangd for C/C++ files
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '--background-index']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
        autocmd FileType c,cpp setlocal omnifunc=lsp#complete
        autocmd FileType c,cpp nmap <buffer> gd <plug>(lsp-definition)
        autocmd FileType c,cpp nmap <buffer> gr <plug>(lsp-references) 
        autocmd FileType c,cpp nmap <buffer> gi <plug>(lsp-implementation)
        autocmd FileType c,cpp nmap <buffer> gt <plug>(lsp-type-definition)
        autocmd FileType c,cpp nmap <buffer> <leader>rn <plug>(lsp-rename)
        autocmd FileType c,cpp nmap <buffer> [g <plug>(lsp-previous-diagnostic)
        autocmd FileType c,cpp nmap <buffer> ]g <plug>(lsp-next-diagnostic)
        autocmd FileType c,cpp nmap <buffer> K <plug>(lsp-hover)
    augroup END
endif

" Enable semantic highlighting
let g:lsp_semantic_enabled = 1

" Show diagnostics (errors/warnings) in real-time
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" Enable auto-completion
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
```

## Cross-Platform Configuration

### Path Detection
```vim
" Auto-detect clangd location across platforms
function! s:find_clangd()
    " Common paths for different platforms
    let l:candidates = [
        \ '/opt/homebrew/bin/clangd',           " macOS Apple Silicon
        \ '/usr/local/bin/clangd',              " macOS Intel  
        \ '/usr/bin/clangd',                    " Linux
        \ '/usr/bin/clangd-12',                 " Linux with version
        \ 'C:\\Program Files\\LLVM\\bin\\clangd.exe',  " Windows
        \ executable('clangd') ? 'clangd' : '' " System PATH
    \ ]
    
    for candidate in l:candidates
        if executable(candidate)
            return candidate
        endif
    endfor
    return ''
endfunction

let g:clangd_path = s:find_clangd()
if !empty(g:clangd_path)
    " Use the detected clangd path in your lsp#register_server call
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->[g:clangd_path, '--background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif
```

### Windows-Specific Considerations
```vim
" Windows path handling
if has('win32') || has('win64')
    " Use forward slashes even on Windows for consistency
    let g:lsp_settings_servers_dir = substitute($HOME . '/.vim/lsp-servers', '\\\\', '/', 'g')
    
    " Handle Windows line endings
    let g:lsp_text_edit_enabled = 1
endif
```

## Project Configuration (compile_commands.json)

Clangd needs to understand your build system. Create a `compile_commands.json` file:

**CMake projects:**
```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
# This creates compile_commands.json automatically
```

**Make projects:**
```bash
# Install bear (build ear)
# macOS: brew install bear  
# Linux: sudo apt install bear
# Windows: Use WSL or manual compilation

bear -- make
# This generates compile_commands.json
```

**Manual compile_commands.json example:**
```json
[
  {
    "directory": "/path/to/project",
    "command": "clang++ -std=c++17 -I./include -c main.cpp",
    "file": "main.cpp"
  }
]
```

## Key Bindings Reference

| Binding | Action |
|---------|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `<leader>rn` | Rename symbol |
| `K` | Show hover information |
| `[g` | Previous diagnostic |
| `]g` | Next diagnostic |

## Testing the Setup

1. **Open a C++ file** with some variables and functions
2. **Check LSP status:** `:LspStatus` 
3. **Test completion:** Start typing and see if you get completions
4. **Test navigation:** Put cursor on a function name and press `gd`
5. **Check highlighting:** Variables should now have semantic colors

## Troubleshooting

**clangd not found:**
- Verify installation: `which clangd` (Unix) or `where clangd` (Windows)
- Check PATH includes clangd directory

**No completions/highlighting:**
- Ensure `compile_commands.json` exists in project root
- Check `:LspStatus` for connection issues
- Try `:LspRestart` to restart the server

**Performance issues:**
- Add `--limit-results=100` to clangd command
- Use `--pch-storage=memory` for faster header parsing

## Alternative: coc.nvim (if you prefer)

```vim
" Alternative LSP client (more VS Code-like)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" After installation:
:CocInstall coc-clangd
```

## Benefits for Your Color Scheme

With clangd + LSP, your onedark color scheme will get:
- **Variables** → Bold bright green (like LLVM registers)  
- **User types** → Proper type colors (orange)
- **Function calls** → Blue (function color)
- **Semantic context** → Colors based on actual code meaning, not just regex patterns

This should give you the same quality highlighting as LLVM files for your C++ code!