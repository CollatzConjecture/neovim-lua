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
map('', '<up>', '<nop>', { desc = 'Disable Up arrow' })
map('', '<down>', '<nop>', { desc = 'Disable Down arrow' })
map('', '<left>', '<nop>', { desc = 'Disable Left arrow' })
map('', '<right>', '<nop>', { desc = 'Disable Right arrow' })

-- Map 'kk' to <Esc> in insert mode (fast escape)
map('i', 'kk', '<Esc>', { desc = 'Fast escape to normal mode' })

-- Clear search highlighting
map('n', '<leader>c', ':nohl<CR>', { desc = 'Clear search highlight' })

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K', { desc = 'Change split vertical to horizontal' })
map('n', '<leader>th', '<C-w>t<C-w>H', { desc = 'Change split horizontal to vertical' })

-- Note: Split navigation (Ctrl + {h,j,k,l}) is handled by tmux navigator
-- See: lua/plugins/tmux.lua

-- Reload config without restart
map('n', '<leader>r', ':so %<CR>', { desc = 'Reload config file' })

-- Fast save
map('n', '<leader>s', ':w<CR>', { desc = 'Save file' })

-- Quit all
map('n', '<leader>q', ':qa!<CR>', { desc = 'Quit all without saving' })

-----------------------------------------------------------
-- Plugin/application keymaps
-----------------------------------------------------------

-- Terminal
map('n', '<C-t>', ':Term<CR>', { noremap = true, desc = 'Open terminal' })
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

-- Add more plugin keymaps below as needed

