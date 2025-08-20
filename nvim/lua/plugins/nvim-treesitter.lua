-----------------------------------------------------------
-- nvim-treesitter configuration file for Neovim
-- Provides better syntax highlighting and code navigation.
-- Source: https://github.com/nvim-treesitter/nvim-treesitter
-- Docs:   https://github.com/nvim-treesitter/nvim-treesitter#quickstart
-----------------------------------------------------------

-- Safely require nvim-treesitter
local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

nvim_treesitter.setup {
  -- List of parser names, or "all"
  -- See: :TSInstallInfo for available parsers
  ensure_installed = {
    'angular', 'awk', 'bash', 'c', 'c_sharp', 'cmake', 'cpp', 'css', 'csv',
    'go', 'haskell', 'html', 'http', 'java', 'javascript', 'json', 'lua',
    'luadoc', 'make', 'markdown', 'markdown_inline', 'nix', 'perl', 'python',
    'ruby', 'rust', 'sql', 'toml', 'typescript', 'vim', 'yaml'
  },
  sync_install = false,  -- Install parsers asynchronously
  highlight = {
    enable = true,       -- Enable treesitter-based highlighting
  },
}

-- For more options and advanced configuration, see:
-- https://github.com/nvim-treesitter/nvim-treesitter#quickstart
