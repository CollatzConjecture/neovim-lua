# Neovim Lua Config Cheat Sheet

## NvimTree Quick Help
- `g?` inside the tree: open the built-in NvimTree help/mappings window.
- `<leader>e`: toggle the file explorer.
- `<leader>f`: refresh the tree.
- `<leader>n`: focus the current buffer inside the tree.

## Neovim Leader Keys
- `Space`: primary leader.
- `\`: local leader.

## Core Navigation
- `kk`: exit insert mode.
- `<leader>c`: clear search highlighting.
- `<leader>r`: reload the current config file.
- `<leader>s`: save the buffer.
- `<leader>q`: quit all without saving.

## Telescope
- `<leader>ff`: find files.
- `<leader>fg`: live grep.
- `<leader>fb`: list buffers.
- `<leader>fh`: search help tags.

## LSP Essentials
- `gd`: go to definition.
- `gD`: go to declaration.
- `gi`: go to implementation.
- `gr`: find references.
- `K`: show hover documentation.
- `<leader>rn`: rename symbol.
- `<leader>ca`: code actions.
- `<leader>f`: format buffer.
- `gl`: show line diagnostics.
- `[d` / `]d`: previous / next diagnostic.

## Terminal Shortcuts
- `Ctrl+t`: open the embedded terminal.
- In terminal mode: `Esc` returns to normal mode.

## Tmux Integration
- Prefix key: `Ctrl+a`.
- `Ctrl+a` then `?`: open tmux’s built-in keybinding help page.
- `Ctrl+a` then `c`: create window.
- `Ctrl+a` then `|` / `-`: split horizontally / vertically.
- `Ctrl+a` then `Ctrl+h` / `Ctrl+l`: previous / next window.
- `Alt+1-9`: jump to window 1-9.
- Pane navigation with Neovim splits: `Ctrl+h/j/k/l`.
- Copy mode: `Ctrl+a` then `[`; use `h/j/k/l` to move, `v` to select, `y` to yank.
- Session management: `Ctrl+a` then `N` to create, `Ctrl+a` then `X` to kill.
