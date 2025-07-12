-----------------------------------------------------------
-- LSP configuration file for Neovim
-- Sets up language servers using mason.nvim and nvim-lspconfig.
-- Source: https://github.com/neovim/nvim-lspconfig
-- Mason:  https://github.com/williamboman/mason.nvim
-- Mason-lspconfig: https://github.com/williamboman/mason-lspconfig.nvim
-- nvim-cmp: https://github.com/hrsh7th/nvim-cmp
-----------------------------------------------------------

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Safely require lspconfig and nvim-cmp capabilities
local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

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
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- Actions
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
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

-- Setup mason-lspconfig to ensure servers are installed
require('mason-lspconfig').setup({
  ensure_installed = servers,
})

-- Setup each server with nvim-cmp capabilities and on_attach
for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-----------------------------------------------------------
-- Diagnostic UI settings and keymaps
-----------------------------------------------------------
vim.diagnostic.config({
  update_in_insert = true,
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
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- For more info and advanced configuration, see:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
