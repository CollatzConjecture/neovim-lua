-----------------------------------------------------------
-- Color schemes configuration file for Neovim
-- All theme setups are here for easy switching.
-- To switch the default theme, change the vim.cmd.colorscheme(...) line at the bottom.
-----------------------------------------------------------

-- =====================
-- Catppuccin (default)
-- Source: https://github.com/catppuccin/nvim
-- Docs:   https://github.com/catppuccin/nvim#usage
-- =====================
-- Catppuccin setup (default flavor: mocha)
require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = false,
  integrations = {
    alpha = true,
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    telescope = true,
    mason = true,
  },
})

-- =====================
-- OneDark
-- Source: https://github.com/navarasu/onedark.nvim
-- Docs:   https://github.com/navarasu/onedark.nvim#configuration
-- =====================
require('onedark').setup({
  style = 'darker',
  colors = { fg = '#b2bbcc' },
  code_style = {
    comments = 'none',
    keywords = 'bold',
    functions = 'bold',
    strings = 'none',
    variables = 'none'
  },
})

-- =====================
-- Kanagawa
-- Source: https://github.com/rebelot/kanagawa.nvim
-- Docs:   https://github.com/rebelot/kanagawa.nvim#configuration
-- =====================
require('kanagawa').setup({
  undercurl = false,
  commentStyle = { italic = false },
  functionStyle = { bold = true },
  keywordStyle = { italic = false, bold = true },
  statementStyle = { bold = true },
  typeStyle = {},
  colors = {
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  theme = "wave",
  background = {
    dark = "wave",
    light = "lotus"
  },
})

-- =====================
-- Monokai Pro
-- Source: https://github.com/loctvl842/monokai-pro.nvim
-- Docs:   https://github.com/loctvl842/monokai-pro.nvim#-configuration
-- =====================
require('monokai-pro').setup({
  styles = {
    comment = { italic = false },
    keyword = { italic = true },
    type = { italic = false },
    storageclass = { italic = true },
    structure = { italic = false },
    parameter = { italic = false },
    annotation = { italic = true },
    tag_attribute = { italic = true },
  },
})

-----------------------------------------------------------
-- Set your default colorscheme here
-- Only one should be uncommented at a time.
-----------------------------------------------------------
vim.cmd.colorscheme("catppuccin")
--vim.cmd.colorscheme("onedark")
--vim.cmd("colorscheme kanagawa")
--vim.cmd("colorscheme monokai-pro")
--vim.cmd("colorscheme rose-pine")

-----------------------------------------------------------
-- Helper: Quick theme switcher (optional)
-- Uncomment and use :lua SwitchTheme("onedark") etc. in command mode
-- function SwitchTheme(name)
--   vim.cmd.colorscheme(name)
-- end
-----------------------------------------------------------

