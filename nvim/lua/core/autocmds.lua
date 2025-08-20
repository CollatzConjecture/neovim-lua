-----------------------------------------------------------
-- Autocommand configuration file for Neovim
-- Defines custom autocommands for various events and filetypes.
-- See: https://neovim.io/doc/user/autocmd.html
-----------------------------------------------------------

-- Helper functions for autocommands
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-----------------------------------------------------------
-- General autocommands
-----------------------------------------------------------

-- Highlight on yank
-- See: :h TextYankPost
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 1000 })
  end
})

-- Remove trailing whitespace on save
-- See: :h BufWritePre
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Don't auto comment new lines
-- See: :h formatoptions
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})

-----------------------------------------------------------
-- Filetype-specific autocommands
-----------------------------------------------------------

-- Disable line length marker for certain filetypes
augroup('setLineLength', { clear = true })
autocmd('Filetype', {
  group = 'setLineLength',
  pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
  command = 'setlocal cc=0'
})

-- Set indentation to 2 spaces for certain filetypes
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-----------------------------------------------------------
-- Terminal autocommands
-----------------------------------------------------------

-- Open a Terminal on the right tab
-- See: :h :command
autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
-- See: :h Terminal-mode
autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert'
})

autocmd('BufWinEnter', {
  pattern = 'term://*',
  command = 'startinsert'
})

-----------------------------------------------------------
-- Add more custom autocommands below as needed
-----------------------------------------------------------
