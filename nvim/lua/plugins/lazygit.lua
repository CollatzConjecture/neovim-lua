-----------------------------------------------------------
-- LazyGit configuration file for Neovim
-- Provides an in-editor floating UI for lazygit.
-- Source: https://github.com/kdheepak/lazygit.nvim
-----------------------------------------------------------

local M = {}

function M.setup()
  if vim.fn.executable('lazygit') == 0 then
    vim.notify('LazyGit binary not found. Install lazygit to use :LazyGit.', vim.log.levels.WARN)
    return
  end

  -- Keep the floating terminal close to the editor size without covering it entirely.
  vim.g.lazygit_floating_window_scaling_factor = 0.9
  vim.g.lazygit_floating_window_winblend = 0
  vim.g.lazygit_use_neovim_remote = 0
end

M.setup()

return M
