-----------------------------------------------------------
-- LSP configuration file for Neovim
-- Sets up language servers using mason.nvim and the native LSP API.
-- Docs:    https://neovim.io/doc/user/lsp.html
-- Mason:  https://github.com/williamboman/mason.nvim
-- Mason-lspconfig: https://github.com/williamboman/mason-lspconfig.nvim
-- nvim-cmp: https://github.com/hrsh7th/nvim-cmp
-----------------------------------------------------------

require('mason').setup()

-- Safely require nvim-cmp capabilities (skip if missing)
local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- on_attach: Set up keymaps and highlighting after LSP attaches
local on_attach = function(client, bufnr)
  -- Document highlight (if supported by server)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end

  -- LSP keymaps (buffer-local)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- Navigation
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', bufopts, { desc = 'Go to definition' }))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', bufopts, { desc = 'Go to declaration' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', bufopts, { desc = 'Go to implementation' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', bufopts, { desc = 'Show references' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', bufopts, { desc = 'Show hover documentation' }))
  -- Actions
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', bufopts, { desc = 'Rename symbol' }))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', bufopts, { desc = 'Code action' }))
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend('force', bufopts, { desc = 'Format buffer' }))
end

-----------------------------------------------------------
-- List of language servers to be automatically installed
-----------------------------------------------------------
local servers = {
  'bashls',    -- Bash
  'pyright',   -- Python
  'clangd',    -- C/C++
  'html',      -- HTML
  'cssls',     -- CSS
  'ts_ls',     -- TypeScript/JavaScript
  'lua_ls',    -- Lua
}

-- Setup mason-lspconfig to auto-install and configure servers
require('mason-lspconfig').setup({
  ensure_installed = servers,
  handlers = {
    -- Default handler for all servers
    function(server_name)
      require('lspconfig')[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
})

-----------------------------------------------------------
-- Diagnostic UI settings and keymaps
-----------------------------------------------------------

-- Define diagnostic signs
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Show line diagnostics automatically in hover window
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })]])

-- Diagnostic navigation keymaps (global)
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show line diagnostics' }))
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Go to previous diagnostic' }))
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Go to next diagnostic' }))
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, vim.tbl_extend('force', opts, { desc = 'Add diagnostics to location list' }))

-- For more info and advanced configuration, see :help lsp.
