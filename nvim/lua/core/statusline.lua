-----------------------------------------------------------
-- Statusline configuration file for Neovim
-- Sets up lualine.nvim for a modern, informative statusline.
-- Source: https://github.com/nvim-lualine/lualine.nvim
-- Docs:   https://github.com/nvim-lualine/lualine.nvim#usage-and-customization
-----------------------------------------------------------

-- Safely require lualine
local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

lualine.setup {
  -- Global options
  options = {
    icons_enabled = true,                -- Enable icons in statusline
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
      'NvimTree',
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = false,
    globalstatus = true,                 -- Single statusline for all windows
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },

  -- Active window sections
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      'diff',
      { 'diagnostics', sources = {'nvim_lsp'} },
    },
    lualine_c = {
      { 'filename', path = 3 },          -- Show full file path
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },

  -- Inactive window sections
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { 'filename', path = 3 },
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },

  -- Tabline and winbar (optional, can be customized)
  tabline = {},
  winbar = {
    lualine_c = {
      { 'filename', path = 0 },          -- Show filename only
    },
  },
  inactive_winbar = {},
  extensions = {},
}

-- To customize further, see the lualine.nvim README and wiki:
-- https://github.com/nvim-lualine/lualine.nvim/wiki

