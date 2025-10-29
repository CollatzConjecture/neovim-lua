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

local keymaps = require('core/keymaps')

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

  keymaps.setup_lsp(bufnr)

  -- Tell LuaLS about Neovim globals when it attaches
  if client.name == 'lua_ls' then
    client.notify("workspace/didChangeConfiguration", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { 'vim' } },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
        },
      },
    })
  end
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
      if server_name == 'lua_ls' then
        require('lspconfig')[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              diagnostics = { globals = { 'vim' } },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = { enable = false },
            },
          },
        })
      else
        require('lspconfig')[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
})

-----------------------------------------------------------
-- Diagnostic UI settings and keymaps
-----------------------------------------------------------

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
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

-- For more info and advanced configuration, see :help lsp.
