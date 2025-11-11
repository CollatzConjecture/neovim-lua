-----------------------------------------------------------
-- Keymaps configuration file for Neovim
-- Defines custom keybindings for core actions and plugins.
-- See: https://neovim.io/doc/user/map.html
-----------------------------------------------------------

local M = {}

-- Global mappings ------------------------------------------------------------
function M.setup_global()
  -- Leader keys
  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'

  -- Default options for mappings
  local opts = { noremap = true, silent = true }

  -- Disable arrow keys for movement (encourage hjkl)
  vim.keymap.set('', '<up>', '<nop>', { desc = 'Disable Up arrow' })
  vim.keymap.set('', '<down>', '<nop>', { desc = 'Disable Down arrow' })
  vim.keymap.set('', '<left>', '<nop>', { desc = 'Disable Left arrow' })
  vim.keymap.set('', '<right>', '<nop>', { desc = 'Disable Right arrow' })

  -- Fast escape to normal mode
  vim.keymap.set('i', 'kk', '<Esc>', { desc = 'Fast escape to normal mode' })

  -- Clear search highlighting
  vim.keymap.set('n', '<leader>c', '<cmd>nohl<CR>', { desc = 'Clear search highlight' })

  -- Change split orientation
  vim.keymap.set('n', '<leader>tk', '<C-w>t<C-w>K', { desc = 'Change split vertical to horizontal' })
  vim.keymap.set('n', '<leader>th', '<C-w>t<C-w>H', { desc = 'Change split horizontal to vertical' })

  -- Reload config without restart
  vim.keymap.set('n', '<leader>r', '<cmd>so %<CR>', { desc = 'Reload config file' })

  -- Fast save
  vim.keymap.set('n', '<leader>s', '<cmd>w<CR>', { desc = 'Save file' })

  -- Quit all
  vim.keymap.set('n', '<leader>q', '<cmd>qa!<CR>', { desc = 'Quit all without saving' })

  -- Terminal shortcuts
  vim.keymap.set('n', '<C-t>', '<cmd>Term<CR>', { desc = 'Open terminal' })
  vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- NvimTree (file explorer)
  vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
  vim.keymap.set('n', '<leader>f', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh NvimTree' })
  vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeFindFile<CR>', { desc = 'Find file in NvimTree' })

  -- Tagbar (code outline)
  vim.keymap.set('n', '<leader>t', '<cmd>TagbarToggle<CR>', { desc = 'Toggle Tagbar' })

  -- Telescope (fuzzy finder)
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Live grep' })
  vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'List buffers' })
  vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Search help tags' })

  -- Diagnostics (global)
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = 'Add diagnostics to location list' })
end

-- LSP buffer-local mappings ---------------------------------------------------
function M.setup_lsp(bufnr)
  local opts = { buffer = bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Show references' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Show hover documentation' }))
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code action' }))
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend('force', opts, { desc = 'Format buffer' }))
end

-- GitSigns buffer-local mappings ----------------------------------------------
function M.setup_gitsigns(bufnr)
  local gs = package.loaded.gitsigns
  if not gs then
    return
  end
  vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Git preview hunk' })
  vim.keymap.set('n', '<leader>gr', gs.refresh, { buffer = bufnr, desc = 'Git refresh signs' })
  vim.keymap.set('n', '<leader>gb', gs.blame_line, { buffer = bufnr, desc = 'Git blame line' })
  vim.keymap.set('n', '<leader>gR', gs.reset_hunk, { buffer = bufnr, desc = 'Git reset hunk' })
  vim.keymap.set('n', ']c', gs.next_hunk, { buffer = bufnr, desc = 'Go to next hunk' })
  vim.keymap.set('n', '[c', gs.prev_hunk, { buffer = bufnr, desc = 'Go to previous hunk' })
end

-- Immediately apply global mappings
M.setup_global()

return M
