-----------------------------------------------------------
-- Telescope configuration file for Neovim
-- Sets up fuzzy finding and picker UI for files, buffers, etc.
-- Source: https://github.com/nvim-telescope/telescope.nvim
-- Docs:   https://github.com/nvim-telescope/telescope.nvim#usage
-----------------------------------------------------------

-- Safely require telescope
local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

-- Setup telescope
telescope.setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

-- Load extensions
-- ui-select: better UI for code actions, etc.
telescope.load_extension("ui-select")

-- For more options and advanced configuration, see:
-- https://github.com/nvim-telescope/telescope.nvim#usage
  