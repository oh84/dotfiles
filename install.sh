#!/usr/bin/env bash

set -eu

SCRIPT_PATH="${BASH_SOURCE[0]:-$0}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"

CONFIGS_DIR="$SCRIPT_DIR/configs"
BACKUP_DIR="$SCRIPT_DIR/.backup/$(date +%Y%m%d%H%M%S)"

# ==============================================================================
# Functions
# ==============================================================================

backup() {
  local file="$1"
  local backup_dir="$BACKUP_DIR/$file"
  if [[ -f "$file" || -d "$file" ]]; then
    mkdir -p "$(dirname "$backup_dir")"
    cp -rL "$file" "$backup_dir"
  fi
}

is_macos() {
  [[ "$OSTYPE" == "darwin"* ]]
  return $?
}

is_linux() {
  [[ "$OSTYPE" == "linux-gnu"* ]]
  return $?
}

# ==============================================================================
# Install Homebrew packages
# ==============================================================================

if ! command -v brew &>/dev/null; then
  # https://docs.brew.sh/Installation
  echo "Homebrew is not installed, installing..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if is_linux; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

backup "$HOME/.Brewfile"
ln -svf "$CONFIGS_DIR/.Brewfile" "$HOME/.Brewfile"
backup "$HOME/.Brewfile.cask"
ln -svf "$CONFIGS_DIR/.Brewfile.cask" "$HOME/.Brewfile.cask"
backup "$HOME/.Brewfile.mas"
ln -svf "$CONFIGS_DIR/.Brewfile.mas" "$HOME/.Brewfile.mas"

brew bundle --global # from $HOME/.Brewfile
# brew bundle --file "$HOME/.Brewfile.cask"
# brew bundle --file "$HOME/.Brewfile.mas"

# ==============================================================================
# Install configuration files
# ==============================================================================

# ----------------------------------------------------------
# git
# ----------------------------------------------------------

mkdir -p "$HOME/.config/git"

# config
backup "$HOME/.config/git/config"
ln -svf "$CONFIGS_DIR/.config/git/config" "$HOME/.config/git/config"

# ignore
backup "$HOME/.config/git/ignore"
ln -svf "$CONFIGS_DIR/.config/git/ignore" "$HOME/.config/git/ignore"

# hooks (ディレクトリをリンク)
backup "$HOME/.config/git/hooks"
ln -svf "$CONFIGS_DIR/.config/git/hooks" "$HOME/.config/git"

# templates (ディレクトリをリンク)
backup "$HOME/.config/git/templates"
ln -svf "$CONFIGS_DIR/.config/git/templates" "$HOME/.config/git"

# private config (ディレクトリをリンク)
backup "$HOME/.config/git/private"
ln -svf "$CONFIGS_DIR/.config/git/private" "$HOME/.config/git"

# ----------------------------------------------------------
# zsh
# ----------------------------------------------------------

# zshrc
backup "$HOME/.zshrc"
ln -svf "$CONFIGS_DIR/.zshrc" "$HOME/.zshrc"

# sheldon
mkdir -p "$HOME/.config/sheldon"
backup "$HOME/.config/sheldon/plugins.toml"
ln -svf "$CONFIGS_DIR/.config/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

# ----------------------------------------------------------
# starship
# ----------------------------------------------------------

mkdir -p "$HOME/.config"
backup "$HOME/.config/starship.toml"
ln -svf "$CONFIGS_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# ----------------------------------------------------------
# tmux
# ----------------------------------------------------------

# tmux.conf
backup "$HOME/.tmux.conf"
ln -svf "$CONFIGS_DIR/.tmux.conf" "$HOME/.tmux.conf"

# tpm
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  mkdir -p "$HOME/.tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

  # For tmux-logging
  if [[ ! -f "$HOME/logs/tmux" ]]; then
    mkdir -p "$HOME/logs/tmux"
  fi
fi

# ----------------------------------------------------------
# vim
# ----------------------------------------------------------

# vimrc
backup "$HOME/.vimrc"
ln -svf "$CONFIGS_DIR/.vimrc" "$HOME/.vimrc"

# vim-plug
if [[ ! -d "$HOME/.vim/plugged" ]]; then
  mkdir -p "$HOME/.vim/plugged"
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# ----------------------------------------------------------
# mise
# ----------------------------------------------------------

# config.toml
mkdir -p "$HOME/.config/mise"
backup "$HOME/.config/mise/config.toml"
ln -svf "$CONFIGS_DIR/.config/mise/config.toml" "$HOME/.config/mise/config.toml"

# Default packages
backup "$HOME/.default-gems"
ln -svf "$CONFIGS_DIR/.default-gems" "$HOME/.default-gems"
backup "$HOME/.default-go-packages"
ln -svf "$CONFIGS_DIR/.default-go-packages" "$HOME/.default-go-packages"
backup "$HOME/.default-npm-packages"
ln -svf "$CONFIGS_DIR/.default-npm-packages" "$HOME/.default-npm-packages"
backup "$HOME/.default-python-packages"
ln -svf "$CONFIGS_DIR/.default-python-packages" "$HOME/.default-python-packages"

# vimのcoc.nvimプラグインで必要なのでインストールしておく
mise install node

# ----------------------------------------------------------
# secretlint
# ----------------------------------------------------------

mkdir -p "$HOME/.config/secretlint"
backup "$HOME/.config/secretlint/.secretlintrc.json"
ln -svf "$CONFIGS_DIR/.config/secretlint/.secretlintrc.json" "$HOME/.config/secretlint/.secretlintrc.json"

# ----------------------------------------------------------
# ghostty
# ----------------------------------------------------------

mkdir -p "$HOME/.config/ghostty"
backup "$HOME/.config/ghostty/config"
ln -svf "$CONFIGS_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"

# ----------------------------------------------------------
# Claude
# ----------------------------------------------------------

mkdir -p "$HOME/.claude"
backup "$HOME/.claude/CLAUDE.md"
ln -svf "$CONFIGS_DIR/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
backup "$HOME/.claude/settings.json"
ln -svf "$CONFIGS_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
backup "$HOME/.claude/statusline.sh"
ln -svf "$CONFIGS_DIR/.claude/statusline.sh" "$HOME/.claude/statusline.sh"
backup "$HOME/.claude/commands"
ln -svf "$CONFIGS_DIR/.claude/commands" "$HOME/.claude" # ディレクトリをリンク
backup "$HOME/.claude/skills"
ln -svf "$CONFIGS_DIR/.claude/skills" "$HOME/.claude" # ディレクトリをリンク

# ----------------------------------------------------------
# karabiner
# ----------------------------------------------------------

# ファイルではなく ~/.config/karabiner ディレクトリをリンクする
# https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/
if is_macos; then
  mkdir -p "$HOME/.config"
  backup "$HOME/.config/karabiner"
  ln -svf "$CONFIGS_DIR/.config/karabiner" "$HOME/.config"
fi

# ----------------------------------------------------------
# hammerspoon
# ----------------------------------------------------------

if is_macos; then
  mkdir -p "$HOME/.hammerspoon"
  backup "$HOME/.hammerspoon/init.lua"
  ln -svf "$CONFIGS_DIR/.hammerspoon/init.lua" "$HOME/.hammerspoon/init.lua"
fi
