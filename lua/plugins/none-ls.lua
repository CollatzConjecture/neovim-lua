-----------------------------------------------------------
-- none-ls.nvim configuration file for Neovim
-- Integrates external formatters/linters as LSP sources.
-- Source: https://github.com/nvimtools/none-ls.nvim
-- Docs:   https://github.com/nvimtools/none-ls.nvim#usage
-----------------------------------------------------------

-- Safely require none-ls (formerly null-ls)
local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  return
end

null_ls.setup({
  sources = {
    -- Formatters
    null_ls.builtins.formatting.stylua,      -- Lua
    null_ls.builtins.formatting.prettier,    -- JavaScript / TypeScript
    null_ls.builtins.formatting.black,       -- Python
    -- Add more formatters/linters as needed
  },
})

-- Keymap: <leader>gf to format using LSP (works for all LSP/none-ls sources)
vim.keymap.set('n', '<leader>gf', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Format file (LSP/none-ls)' })

-- For more info and advanced configuration, see:
-- https://github.com/nvimtools/none-ls.nvim#usage 