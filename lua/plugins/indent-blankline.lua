-----------------------------------------------------------
-- Indent-blankline configuration file for Neovim
-- Adds indentation guides to all lines (except excluded filetypes).
-- Source: https://github.com/lukas-reineke/indent-blankline.nvim
-- Docs:   https://github.com/lukas-reineke/indent-blankline.nvim#setup
-----------------------------------------------------------

-- Safely require indent-blankline (ibl)
local status_ok, ibl = pcall(require, 'ibl')
if not status_ok then
  return
end

ibl.setup {
  -- Character used for indentation guides
  indent = { char = "▎" },

  -- Exclude certain filetypes and buffer types
  exclude = {
    filetypes = {
      'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'dashboard', 'git',
      'markdown', 'text', 'terminal', 'NvimTree',
    },
    buftypes = {
      'terminal', 'nofile', 'quickfix', 'prompt',
    },
  },
}

-- For more options and advanced configuration, see:
-- https://github.com/lukas-reineke/indent-blankline.nvim#setup
