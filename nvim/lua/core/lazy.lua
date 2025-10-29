-----------------------------------------------------------
-- Plugin manager configuration file for Neovim
-- Uses lazy.nvim for fast, modular plugin management.
-- Source: https://github.com/folke/lazy.nvim
-- Docs:   https://lazy.folke.io/
-----------------------------------------------------------

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Safely require lazy.nvim
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

-- Main lazy.nvim setup
lazy.setup({
  -- Default plugin loading behavior
  defaults = {
    lazy = false, -- Plugins are loaded at startup by default
    version = nil, -- Always use latest commit
    cond = nil,    -- No global condition
  },

  -- UI configuration for :Lazy
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    border = "none",
    backdrop = 60,
    pills = true,
    icons = {
      cmd = " ",
      config = "",
      debug = "● ",
      event = " ",
      favorite = " ",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = " ",
      task = "✔ ",
      list = { "●", "➜", "★", "‒" },
    },
    custom_keys = {
      ["<localleader>l"] = {
        function(plugin)
          require("lazy.util").float_term({ "lazygit", "log" }, { cwd = plugin.dir })
        end,
        desc = "Open lazygit log",
      },
      ["<localleader>i"] = {
        function(plugin)
          Util.notify(vim.inspect(plugin), { title = "Inspect " .. plugin.name, lang = "lua" })
        end,
        desc = "Inspect Plugin",
      },
      ["<localleader>t"] = {
        function(plugin)
          require("lazy.util").float_term(nil, { cwd = plugin.dir })
        end,
        desc = "Open terminal in plugin dir",
      },
    },
  },

  -- Output options for headless mode
  headless = {
    process = true,
    log = true,
    task = true,
    colors = true,
  },

  -- Diff and update options
  diff = { cmd = "git" },
  checker = {
    enabled = false,
    notify = true,
    frequency = 3600,
    check_pinned = false,
  },
  change_detection = {
    enabled = true,
    notify = true,
  },
  readme = {
    enabled = true,
    root = vim.fn.stdpath("state") .. "/lazy/readme",
    files = { "README.md", "lua/**/README.md" },
    skip_if_doc_exists = true,
  },
  state = vim.fn.stdpath("state") .. "/lazy/state.json",
  profiling = {
    loader = false,
    require = false,
  },

  -----------------------------------------------------------
  -- Plugin specification (edit this section to add/remove plugins)
  -----------------------------------------------------------
  spec = {
    -- Colorschemes (see /lua/core/colors.lua for config)
    {
      'catppuccin/nvim',
      lazy = false,
      name = 'catppuccin',
      priority = 1000,
    },
    { 'navarasu/onedark.nvim', lazy = true },       -- OneDark
    { 'rebelot/kanagawa.nvim', lazy = true },       -- Kanagawa
    { 'loctvl842/monokai-pro.nvim', lazy = true },  -- Monokai Pro
    { 'https://github.com/rose-pine/neovim', name = 'rose-pine', lazy = true }, -- Rosè Pine

    -- Icons
    { 'kyazdani42/nvim-web-devicons', lazy = true },

    -- Dashboard (start screen)
    {
      'goolord/alpha-nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    -- Git integration
    { 'tpope/vim-fugitive' },

    -- Git labels
    {
      'lewis6991/gitsigns.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('gitsigns').setup{
          watch_gitdir = {
            interval = 500,  -- Check for git changes every 500ms (faster refresh)
            follow_files = true
          },
          current_line_blame = false,
          update_debounce = 100,
          -- Auto-refresh after saving
          attach_to_untracked = true,
          on_attach = function(bufnr)
            require('core/keymaps').setup_gitsigns(bufnr)
          end,
        }
      end
    },

    -- File explorer
    {
      'kyazdani42/nvim-tree.lua',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    -- Statusline
    {
      'nvim-lualine/lualine.nvim',
      dependencies = {
        'kyazdani42/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
      },
    },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- Indent line
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },

    -- Tag viewer
    { 'preservim/tagbar' },

    -- Autopair
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup{}
      end
    },

    -- Tmux integration
    {
      'christoomey/vim-tmux-navigator',
      config = function()
        require('plugins.tmux')
      end
    },

    -- LSP
    {
      'williamboman/mason.nvim',
      build = ':MasonUpdate',
    },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },

    -- Telescope (fuzzy finder)
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.5',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
      },
    },

    -- Autocomplete
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
      },
    },

    -- none-ls (external formatters/linters)
    {
      'nvimtools/none-ls.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('plugins.none-ls')
      end,
    },
  },
})

-- For more info and advanced configuration, see:
-- https://lazy.folke.io/configuration
