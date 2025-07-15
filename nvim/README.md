# Neovim Configuration

This is a modular, modern Neovim configuration designed for productivity, aesthetics, and ease of use. It uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management and is centered around the beautiful **onemonokai** theme.

## Features

- Fast startup and lazy loading of plugins
- Clean, maintainable Lua code structure
- Pre-configured keymaps for efficient navigation and editing
- Modern UI with [onemonokai](https://github.com/bryanwills/one_monokai.nvim) theme

## Installation

1. **Clone this repository** into your Neovim config directory:
   ```sh
   git clone https://github.com/bryanwills/nvim ~/.config/nvim
   ```
2. **Open Neovim** and plugins will be installed automatically via `lazy.nvim`.
3. **Font Recommendation:** Use a Nerd Font (e.g., [MesloLGS Nerd Font](https://www.nerdfonts.com/)) for best icon support.

## Main Plugins

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim): Lua functions used by many plugins
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator): Seamless navigation between tmux and Vim splits
- [one_monokai.nvim](https://github.com/bryanwills/one_monokai.nvim): The main colorscheme/theme

## Theme

This config uses **onemonokai** as the only theme. All previous theme logic (e.g., tokyonight) has been removed for simplicity and consistency.

## Custom Keyboard Shortcuts

Below is a quick reference for the custom keymaps defined in this config. The `<leader>` key is set to the spacebar (`<Space>`).

| Mode | Shortcut     | Action              | Description                    |
| ---- | ------------ | ------------------- | ------------------------------ |
| i    | jk           | `<ESC>`             | Exit insert mode with jk       |
| n    | `<leader>nh` | `:nohl<CR>`         | Clear search highlights        |
| n    | `<leader>+`  | `<C-a>`             | Increment number               |
| n    | `<leader>-`  | `<C-x>`             | Decrement number               |
| n    | `<leader>sv` | `<C-w>v`            | Split window vertically        |
| n    | `<leader>sh` | `<C-w>s`            | Split window horizontally      |
| n    | `<leader>se` | `<C-w>=`            | Make splits equal size         |
| n    | `<leader>sx` | `<cmd>close<CR>`    | Close current split window     |
| n    | `<leader>to` | `<cmd>tabnew<CR>`   | Open new tab                   |
| n    | `<leader>tx` | `<cmd>tabclose<CR>` | Close current tab              |
| n    | `<leader>tn` | `<cmd>tabn<CR>`     | Go to next tab                 |
| n    | `<leader>tp` | `<cmd>tabp<CR>`     | Go to previous tab             |
| n    | `<leader>tf` | `<cmd>tabnew %<CR>` | Open current buffer in new tab |

- **Modes:** `n` = normal, `i` = insert
- `<leader>` = spacebar

## LazyGit Quick Shortcuts

Here are some useful LazyGit shortcuts for managing your git workflow:

| Action       | Key in LazyGit  | What it does               |
| ------------ | --------------- | -------------------------- |
| Stage file   | `space`         | Stage/unstage file         |
| Commit       | `c`             | Open commit message prompt |
| Push         | `P` (shift + p) | Push to remote (GitHub)    |
| Pull         | `p`             | Pull from remote           |
| Fetch        | `f`             | Fetch from remote          |
| Quit LazyGit | `q`             | Exit LazyGit               |
| cz commit    | `C` (shift + c) | cz commit                  |

**Typical workflow:**

1. Stage your file(s) with `space`.
2. Commit with `c` or `C` and enter your message.
3. Push with `P`.

## Using Commitizen with LazyGit

[Commitizen](https://commitizen-tools.github.io/commitizen/) helps you write standardized commit messages. You can integrate it with LazyGit for a better commit experience.

### 1. Install Commitizen

```sh
pip install -U commitizen  # Python version
# or
npm install -g commitizen  # Node.js version
```

### 2. Add a Commitizen Configuration

Create a `.cz.toml` (for Python) or `.czrc` (for Node.js) in your repo root. Example for Python:

```toml
[tool.commitizen]
name = "cz_conventional_commits"
version = "0.1.0"
tag_format = "v$version"
```

Or for Node.js:

```json
{
  "path": "cz-conventional-changelog"
}
```

### 3. Use Commitizen in LazyGit

- In LazyGit, press `C` (capital C) to open the custom command prompt.
- Type:
  ```sh
  cz commit
  ```
- This will launch the Commitizen prompt for your commit message.
- After committing, push as usual with `P`.

**Tip:** You can also add a custom command in LazyGit's config to make this even easier.

---

Enjoy your new Neovim setup! For questions or suggestions, open an issue or PR on the repo.
