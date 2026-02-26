-- init.lua: Neovim 0.11+ configuration
--
-- Prerequisites (not managed by this config):
--   The tree-sitter C++ parser must be installed into a parser/ directory
--   on Neovim's runtimepath. This config ships the query files
--   (queries/cpp/*.scm) but the compiled parser binary is platform-specific.
--
--   Neovim searches for parser/{lang}.* in every runtimepath directory.
--   The simplest target is the system parser dir alongside the bundled ones.
--
--   macOS (MacPorts):
--     port install tree-sitter-cpp
--     sudo ln -s /opt/local/lib/libtree-sitter-cpp.dylib \
--                /opt/local/lib/nvim/parser/cpp.so
--
--   Linux:
--     Install tree-sitter-cpp via package manager or build from source,
--     then copy/symlink the .so into <prefix>/lib/nvim/parser/cpp.so
--
--   Windows:
--     Build tree-sitter-cpp from source (produces cpp.dll), then place it
--     at ~/AppData/Local/nvim-data/parser/cpp.dll
--     Or use the nvim-treesitter plugin which automates this.

vim.g.mapleader = ","

vim.cmd("colorscheme kippes")

vim.opt.number = true
vim.opt.scrolloff = 2
vim.opt.colorcolumn = "78"
vim.opt.cursorline = true

-- Tree-sitter highlighting for filetypes with parsers available
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "lua" },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- ,ts to force-start tree-sitter (debugging)
vim.keymap.set('n', '<leader>ts', function()
  local ok, err = pcall(vim.treesitter.start)
  if ok then
    print("Tree-sitter started for " .. vim.bo.filetype)
  else
    print("Failed: " .. tostring(err))
  end
end, { desc = "Start Tree-sitter manually" })
