-----------------------------------------------------------
-- Dashboard configuration file for Neovim
-- Sets up alpha-nvim for a beautiful start screen.
-- Source: https://github.com/goolord/alpha-nvim
-- Docs:   https://github.com/goolord/alpha-nvim#quick-start
-----------------------------------------------------------

-- Safely require alpha-nvim
local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
  return
end

-- Use the dashboard theme (other themes: startify, theta)
local dashboard = require('alpha.themes.dashboard')

-- Custom highlight groups for dashboard sections
vim.api.nvim_set_hl(0, 'AlphaHeader',   { fg = '#61afef' })  -- Banner color
vim.api.nvim_set_hl(0, 'AlphaButtons',  { fg = '#56b6c2' })  -- Button text
vim.api.nvim_set_hl(0, 'AlphaShortcut', { fg = '#c678dd' })  -- Shortcut keys
vim.api.nvim_set_hl(0, 'AlphaFooter',   { fg = '#282c34' })  -- Footer

-----------------------------------------------------------
-- Banner (ASCII art)
-- Choose your favorite by setting dashboard.section.header.val = bx
-----------------------------------------------------------
local b0 = {
  "                                                    ",
  " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                    ",
}
local b1 = {
  "                                                   ",
  " ███    ██ ███████  ██████  ██    ██ ██ ███    ███ ",
  " ████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ",
  " ██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ",
  " ██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ",
  " ██   ████ ███████  ██████    ████   ██ ██      ██ ",
  "                                                   "
}
local b2 = {
  "                                                              ",
  " ░   ░░░  ░░        ░░░      ░░░  ░░░░  ░░        ░░  ░░░░  ░ ",
  " ▒    ▒▒  ▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒▒   ▒▒   ▒ ",
  " ▓  ▓  ▓  ▓▓      ▓▓▓▓  ▓▓▓▓  ▓▓▓  ▓▓  ▓▓▓▓▓▓  ▓▓▓▓▓        ▓ ",
  " █  ██    ██  ████████  ████  ████    ███████  █████  █  █  █ ",
  " █  ███   ██        ███      ██████  █████        ██  ████  █ ",
  "                                                              "
}
local b3 = {
  "                                                     ",
  "  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓  ",
  "  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒  ",
  " ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ",
  " ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ",
  " ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ",
  " ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ",
  " ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ",
  "    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ",
  "          ░    ░  ░    ░ ░        ░   ░         ░    ",
  "                                 ░                   ",
  "                                                     "
}
local b4 = {
  "                                                      ",
  " ##    ## ########  #######  ##     ## #### ##     ## ",
  " ###   ## ##       ##     ## ##     ##  ##  ###   ### ",
  " ####  ## ##       ##     ## ##     ##  ##  #### #### ",
  " ## ## ## ######   ##     ## ##     ##  ##  ## ### ## ",
  " ##  #### ##       ##     ##  ##   ##   ##  ##     ## ",
  " ##   ### ##       ##     ##   ## ##    ##  ##     ## ",
  " ##    ## ########  #######     ###    #### ##     ## ",
  "                                                      "
}
local b5 = {
  "                                                             ",
  " '##::: ##:'########::'#######::'##::::'##:'####:'##::::'##: ",
  "  ###:: ##: ##.....::'##.... ##: ##:::: ##:. ##:: ###::'###: ",
  "  ####: ##: ##::::::: ##:::: ##: ##:::: ##:: ##:: ####'####: ",
  "  ## ## ##: ######::: ##:::: ##: ##:::: ##:: ##:: ## ### ##: ",
  "  ##. ####: ##...:::: ##:::: ##:. ##:: ##::: ##:: ##. #: ##: ",
  "  ##:. ###: ##::::::: ##:::: ##::. ## ##:::: ##:: ##:.:: ##: ",
  "  ##::. ##: ########:. #######::::. ###::::'####: ##:::: ##: ",
  " ..::::..::........:::.......::::::...:::::....::..:::::..:: ",
  "                                                             "
}
local b6 = {  
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                     ]],
  [[       ████ ██████           █████      ██                     ]],
  [[      ███████████             █████                             ]],
  [[      █████████ ███████████████████ ███   ███████████   ]],
  [[     █████████  ███    █████████████ █████ ██████████████   ]],
  [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
  [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
  [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
  [[                                                                       ]],
  [[                                                                       ]],
}

-- Set your preferred banner here
-- dashboard.section.header.val = b0, b1, b2, b3, b4, b5, or b6
-- Example:
dashboard.section.header.val = b6
-- Set header highlight group
dashboard.section.header.opts.hl = 'AlphaHeader'

-----------------------------------------------------------
-- Menu (Shortcuts)
-----------------------------------------------------------
dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', ':ene <BAR> startinsert<CR>'),
  dashboard.button('f', '  Find file', ':NvimTreeOpen<CR>'),
  dashboard.button('s', '  Settings', ':e $MYVIMRC<CR>'),
  dashboard.button('u', '  Update plugins', ':Lazy update<CR>'),
  dashboard.button('q', '  Quit', ':qa<CR>'),
}

-- Set button highlight groups
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = 'AlphaButtons'
  button.opts.hl_shortcut = 'AlphaShortcut'
end

-----------------------------------------------------------
-- Footer (version and datetime)
-----------------------------------------------------------
local function footer()
  local version = vim.version()
  local print_version = "v" .. version.major .. '.' .. version.minor .. '.' .. version.patch
  local datetime = os.date('%Y/%m/%d %H:%M')
  return print_version .. ' - ' .. datetime
end

dashboard.section.footer.val = footer()
-- Set footer highlight group
dashboard.section.footer.opts.hl = 'AlphaFooter'

-- Setup alpha-nvim with the dashboard config
alpha.setup(dashboard.config)
