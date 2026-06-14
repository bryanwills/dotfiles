# Linux VPS Setup (Ubuntu + Homebrew)

How to bring an Ubuntu VPS up to the **same** terminal/dev environment as the macOS
machine, using the single cross-platform `~/.config/zsh/.zshrc`. These manual steps are
the source of truth that the Ansible playbooks (Part 2) automate.

The unified `.zshrc` auto-detects the OS and Homebrew prefix (`/home/linuxbrew/.linuxbrew`
on Linux vs `/opt/homebrew` on macOS), guards every path/source with existence checks, and
reads `~/.keys/*` only if present — so the same file is safe to run on a fresh VPS.

---

## 1. Base packages (apt)

```bash
sudo apt update
sudo apt install -y zsh git curl build-essential procps file \
  ncurses-term            # provides tmux-256color terminfo (needed by tmux.conf)
```

Make zsh your login shell:

```bash
chsh -s "$(command -v zsh)"   # log out/in afterwards
```

## 2. Homebrew (Linuxbrew) — already installed on your VPS

If not present:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Ensure it's on PATH (this is also done by `~/.zprofile`, see step 4):

```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

## 3. CLI tools (brew — keeps versions identical to macOS)

```bash
brew install \
  eza bat fzf zoxide git-delta ripgrep fd \
  neovim tmux \
  mise \
  powerlevel10k \
  zsh-autosuggestions zsh-syntax-highlighting zsh-completions
```

> `bat` from brew is the `bat` command (Ubuntu's apt package would be `batcat`). Using brew
> keeps the `alias cat="bat"` in `.zshrc` working unchanged.

## 4. Clone the dotfiles and wire up shell loading

```bash
git clone https://github.com/bryanwills/dotfiles.git ~/.config   # or your preferred layout

# ~/.zshenv makes EVERY shell (login + non-login) use the repo config
ln -sf ~/.config/zsh/.zshenv ~/.zshenv

# ~/.zprofile: Homebrew env + ZDOTDIR for login shells
cat > ~/.zprofile <<'EOF'
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export ZDOTDIR="$HOME/.config/zsh"
EOF
```

## 5. oh-my-zsh + plugins + theme

oh-my-zsh lives in the repo at `zsh/oh-my-zsh`, so `$ZSH` already resolves. Install the
custom plugins the `.zshrc` expects into `zsh/oh-my-zsh/custom/plugins/`:

```bash
ZSH_CUSTOM=~/.config/zsh/oh-my-zsh/custom
git clone --depth=1 https://github.com/Aloxaf/fzf-tab           "$ZSH_CUSTOM/plugins/fzf-tab"
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use "$ZSH_CUSTOM/plugins/you-should-use"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions     "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/zsh-users/zsh-completions          "$ZSH_CUSTOM/plugins/zsh-completions"
```

> If `zsh-autosuggestions`/`zsh-syntax-highlighting` are installed via brew (step 3), you can
> source those instead — but the repo's `plugins=()` array expects them under `custom/plugins`,
> so cloning is the simplest path to parity.

## 6. Runtimes via mise (replaces nvm/rbenv)

```bash
mise use -g node@24
mise use -g ruby@3.2.2     # compiles from source; needs libssl-dev, libreadline-dev, etc.
mise install
```

Build deps for ruby on Ubuntu, if the compile fails:

```bash
sudo apt install -y libssl-dev libreadline-dev zlib1g-dev libyaml-dev autoconf
```

## 7. tmux plugins (TPM)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux                       # then press: prefix (Ctrl+a) + I  to install plugins
```

The shared `tmux.conf` picks the Linuxbrew zsh as a **login** shell automatically, so panes
match the outer environment. `set -g set-clipboard on` makes copy work over SSH via OSC52.

## 8. Neovim plugins

```bash
nvim --headless "+Lazy! restore" +qa   # installs exactly the versions in lazy-lock.json
```

Use `Lazy! restore` (not `sync`) on the VPS to match the macOS-locked plugin versions.

## 9. Powerlevel10k font

Install **MesloLGS NF** for the prompt glyphs (your terminal emulator must use it):

```bash
brew install --cask font-meslo-lg-nerd-font   # if the VPS has a GUI; otherwise install the
                                              # font on the LOCAL machine you SSH from
```

For a headless VPS, the font only needs to exist in the **local** terminal you connect with.

---

## Verify

```bash
exec zsh -l
echo "$ZDOTDIR"          # -> ~/.config/zsh
command -v node ruby     # -> mise shims
echo "$BREW_PREFIX"      # -> /home/linuxbrew/.linuxbrew
```

## Optional: secrets

The `.zshrc` reads `~/.keys/*` only if the files exist. Create them (chmod 600) only if you
need those tokens on the VPS; otherwise they're skipped silently.
