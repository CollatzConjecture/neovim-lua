-----------------------------------------------------------
-- Keymaps configuration file for Neovim
-- Defines custom keybindings for core actions and plugins.
-- See: https://neovim.io/doc/user/map.html
-----------------------------------------------------------

-- Helper function for mapping keys
local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-----------------------------------------------------------
-- Core Neovim keymaps
-----------------------------------------------------------

-- Disable arrow keys for movement (encourage hjkl)
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Map 'kk' to <Esc> in insert mode (fast escape)
map('i', 'kk', '<Esc>')

-- Clear search highlighting
map('n', '<leader>c', ':nohl<CR>')

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- horizontal to vertical

-- Note: Split navigation (Ctrl + {h,j,k,l}) is handled by tmux navigator
-- See: lua/plugins/tmux.lua

-- Reload config without restart
map('n', '<leader>r', ':so %<CR>')

-- Fast save
map('n', '<leader>s', ':w<CR>')

-- Quit all
map('n', '<leader>q', ':qa!<CR>')

-----------------------------------------------------------
-- Plugin/application keymaps
-----------------------------------------------------------

-- Terminal
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open terminal
map('t', '<Esc>', '<C-\\><C-n>')                   -- exit terminal mode

-- NvimTree (file explorer)
map('n', '<leader>e', ':NvimTreeToggle<CR>')        -- open/close
map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- find file

-- Tagbar (code outline)
map('n', '<leader>t', ':TagbarToggle<CR>')          -- open/close

-- Telescope (fuzzy finder)
map('n', '<leader>ff', ':Telescope find_files<CR>') -- find files
map('n', '<leader>fg', ':Telescope live_grep<CR>')  -- live grep
map('n', '<leader>fb', ':Telescope buffers<CR>')    -- list buffers
map('n', '<leader>fh', ':Telescope help_tags<CR>')  -- help tags

-- Add more plugin keymaps below as needed

