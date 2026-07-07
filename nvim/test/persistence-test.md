# Persistence.nvim Test

Use this file to verify session restore works.

## Test steps

1. Open Neovim in this directory:
   ```bash
   nvim ~/.config/nvim/test/persistence-test.md
   ```
2. Open a second buffer, e.g. `:e ~/.config/README.md`
3. Quit Neovim normally with `:qa`
4. Reopen Neovim in the same directory
5. Press `<leader>qs` to restore the session for this directory

## Expected result

Both buffers reopen in the same layout you had before quitting.

## Other commands

- `<leader>qS` — pick a saved session from a list
- `<leader>ql` — restore the most recent session
- `<leader>qd` — stop autosave for the current session

Sessions are stored under `~/.local/state/nvim/sessions/`.
