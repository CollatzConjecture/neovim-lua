-----------------------------------------------------------
-- Tmux integration configuration file for Neovim
-- Sets up seamless navigation between tmux panes and Neovim splits
-- Source: https://github.com/christoomey/vim-tmux-navigator
-- Docs:   https://github.com/christoomey/vim-tmux-navigator#usage
--
-- IMPORTANT: This requires tmux configuration to work properly!
-- Copy the included tmux.conf file to ~/.tmux.conf:
--   cp ~/.config/nvim/tmux.conf ~/.tmux.conf
--   tmux source-file ~/.tmux.conf
-----------------------------------------------------------

-- Safely require tmux navigator
local status_ok, _ = pcall(require, 'vim-tmux-navigator')
if not status_ok then
  return
end

-- Tmux navigator configuration
-- Disable tmux navigator when zooming the tmux pane
vim.g.tmux_navigator_disable_when_zoomed = 1

-- Save on focus lost (useful when switching panes)
vim.g.tmux_navigator_save_on_switch = 2

-- Don't wrap around when navigating
vim.g.tmux_navigator_no_wrap = 1

-- Key mappings for tmux navigation (consistent with default tmux prefix + hjkl)
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', vim.tbl_extend('force', opts, { desc = 'Navigate to left pane' }))
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', vim.tbl_extend('force', opts, { desc = 'Navigate to pane below' }))
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', vim.tbl_extend('force', opts, { desc = 'Navigate to pane above' }))
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', vim.tbl_extend('force', opts, { desc = 'Navigate to right pane' }))
vim.keymap.set('n', '<C-\\>', ':TmuxNavigatePrevious<CR>', vim.tbl_extend('force', opts, { desc = 'Navigate to previous pane' }))

-- Additional tmux integration features
-- Preserve vim splits when navigating
vim.g.tmux_navigator_preserve_zoom = 1

-- For more options and advanced configuration, see:
-- https://github.com/christoomey/vim-tmux-navigator#configuration
