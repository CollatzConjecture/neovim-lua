-----------------------------------------------------------
-- Keymaps configuration file for Neovim
-- Defines custom keybindings for core actions and plugins.
-- See: https://neovim.io/doc/user/map.html
-----------------------------------------------------------

local M = {}

-- Helper for simple string mappings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Global mappings ------------------------------------------------------------
function M.setup_global()
  -- Leader keys
  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'

  -- Disable arrow keys for movement (encourage hjkl)
  map('', '<up>', '<nop>', { desc = 'Disable Up arrow' })
  map('', '<down>', '<nop>', { desc = 'Disable Down arrow' })
  map('', '<left>', '<nop>', { desc = 'Disable Left arrow' })
  map('', '<right>', '<nop>', { desc = 'Disable Right arrow' })

  -- Fast escape to normal mode
  map('i', 'kk', '<Esc>', { desc = 'Fast escape to normal mode' })

  -- Clear search highlighting
  map('n', '<leader>c', ':nohl<CR>', { desc = 'Clear search highlight' })

  -- Change split orientation
  map('n', '<leader>tk', '<C-w>t<C-w>K', { desc = 'Change split vertical to horizontal' })
  map('n', '<leader>th', '<C-w>t<C-w>H', { desc = 'Change split horizontal to vertical' })

  -- Reload config without restart
  map('n', '<leader>r', ':so %<CR>', { desc = 'Reload config file' })

  -- Fast save
  map('n', '<leader>s', ':w<CR>', { desc = 'Save file' })

  -- Quit all
  map('n', '<leader>q', ':qa!<CR>', { desc = 'Quit all without saving' })

  -- Terminal shortcuts
  map('n', '<C-t>', ':Term<CR>', { desc = 'Open terminal' })
  map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- NvimTree (file explorer)
  map('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
  map('n', '<leader>f', ':NvimTreeRefresh<CR>', { desc = 'Refresh NvimTree' })
  map('n', '<leader>n', ':NvimTreeFindFile<CR>', { desc = 'Find file in NvimTree' })

  -- Tagbar (code outline)
  map('n', '<leader>t', ':TagbarToggle<CR>', { desc = 'Toggle Tagbar' })

  -- Telescope (fuzzy finder)
  map('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find files' })
  map('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = 'Live grep' })
  map('n', '<leader>fb', ':Telescope buffers<CR>', { desc = 'List buffers' })
  map('n', '<leader>fh', ':Telescope help_tags<CR>', { desc = 'Search help tags' })

  -- Diagnostics (global)
  local diag_opts = { noremap = true, silent = true }
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, vim.tbl_extend('force', diag_opts, { desc = 'Show line diagnostics' }))
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', diag_opts, { desc = 'Go to previous diagnostic' }))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', diag_opts, { desc = 'Go to next diagnostic' }))
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, vim.tbl_extend('force', diag_opts, { desc = 'Add diagnostics to location list' }))
end

-- LSP buffer-local mappings ---------------------------------------------------
function M.setup_lsp(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local function with_desc(desc)
    return vim.tbl_extend('force', bufopts, { desc = desc })
  end

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, with_desc('Go to definition'))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, with_desc('Go to declaration'))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, with_desc('Go to implementation'))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, with_desc('Show references'))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, with_desc('Show hover documentation'))
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, with_desc('Rename symbol'))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, with_desc('Code action'))
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, with_desc('Format buffer'))
end

-- GitSigns buffer-local mappings ----------------------------------------------
function M.setup_gitsigns(bufnr)
  local gs = package.loaded.gitsigns
  if not gs then
    return
  end
  vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Git preview hunk' })
end

-- Immediately apply global mappings
M.setup_global()

return M

