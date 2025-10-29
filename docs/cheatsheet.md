# Neovim Lua Config Cheat Sheet

## Lazy (Plugin Manager)
- `:Lazy`: open Lazy UI to manage plugins.
- `:Lazy update`: update all plugins to their latest versions.
- `:Lazy sync`: install missing plugins and update existing ones.
- `:Lazy install`: install missing plugins.
- `:Lazy clean`: remove unused/disabled plugins.
- `:Lazy check`: check for plugin updates (without installing).
- `:Lazy restore`: restore plugins to the state in the lockfile.
- `:Lazy profile`: show plugin loading times (performance profiling).
- `:Lazy log`: view recent plugin changes and updates.
- Inside Lazy UI: press `?` for keybinding help, `x` to clear finished tasks, `l` to view logs.

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

## Mason (LSP/Tool Manager)
- `:Mason`: open Mason UI to manage LSP servers, formatters, and linters.
- `:MasonUpdate`: update Mason registry and installed packages.
- `:MasonInstall <package>`: install a specific package (e.g., `:MasonInstall lua-language-server`).
- `:MasonUninstall <package>`: uninstall a package.
- `:MasonLog`: view Mason installation logs (useful for debugging).

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
- `:LspRestart {server}` restarts a language server; `:LspInfo` shows which servers are attached.

## Git Integration (Gitsigns)
- Sign colors: 🟢 Green = added, 🟡 Yellow = modified, 🔴 Red = deleted (vs last commit).
- `<leader>gp`: preview current hunk (shows diff in popup).
- `<leader>gr`: manually refresh git signs (force update).
- `<leader>gb`: show git blame for current line.
- `:LazyGit`: launch the LazyGit floating UI inside Neovim (requires `lazygit` binary).
- `:help gitsigns.txt`: open the full Gitsigns help (try `:help gitsigns.<topic>` for sections like `:help gitsigns.keymaps`).

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
