#!/usr/bin/env zsh

# ==============================================================================
# プラグイン
# ==============================================================================

eval "$(sheldon source)"
export SHELDON_CONFIG_DIR=$HOME/.config/sheldon

# ==============================================================================
# 基本設定
# ==============================================================================

# キーバインド
bindkey -e # emacsモード

# 基本的なシェルオプション
setopt auto_cd           # ディレクトリ名だけでcdする
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt pushd_ignore_dups # 重複したディレクトリをスタックに追加しない
setopt extended_glob     # 拡張グロブを有効にする
setopt no_beep           # ビープ音を鳴らさない
setopt print_eight_bit   # 日本語ファイル名を表示可能にする
setopt ignore_eof        # Ctrl-Dでログアウトしない

# 履歴設定
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000             # メモリ上の履歴リストの最大サイズ
SAVEHIST=1000000            # 履歴ファイルに保存される履歴の最大サイズ
setopt hist_ignore_all_dups # 重複するコマンド行は古い方を削除
setopt hist_ignore_space    # スペースで始まるコマンド行はヒストリに追加しない
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存
setopt share_history        # セッション間で履歴を共有
setopt inc_append_history   # 履歴をインクリメンタルに即時保存

# 文字コード設定
export LANG=ja_JP.UTF-8

# ==============================================================================
# プロンプト
# ==============================================================================

eval "$(starship init zsh)"
export STARSHIP_CONFIG=$HOME/.config/starship.toml

# ==============================================================================
# パス設定
# ==============================================================================

# PATHの設定
typeset -U path PATH
path=(
  $HOME/bin(N-/)
  $HOME/.local/bin(N-/)
  $HOMEBREW_PREFIX/opt/*/libexec/gnubin(N-/)                  # GNU commands for macOS
  $HOMEBREW_PREFIX/share/git-core/contrib/diff-highlight(N-/) # Git diff-highlight for macOS
  /usr/share/doc/git/contrib/diff-highlight(N-/)              # Git diff-highlight for Debian
  $path
)

# MANPATHの設定
typeset -U manpath MANPATH
manpath=(
  $HOMEBREW_PREFIX/opt/*/libexec/gnuman(N-/) # GNU commands for macOS
  $manpath
)
export MANPATH

# エディタの設定
# export EDITOR=nvim

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config

# ==============================================================================
# エイリアス
# ==============================================================================

alias rm='rm -i'               # 削除前に確認
alias cp='cp -i'               # 上書き前に確認
alias mv='mv -i'               # 上書き前に確認
alias grep='grep --color=auto' # 色付きで表示
alias ls='ls -F --color=auto'  # ファイルタイプを記号と色で区別しやすくする

alias ll='ls -la'
alias nix='noglob nix'
alias dk='docker'
alias dkc='docker compose'
alias lzd='lazydocker'
alias lzg='lazygit'
alias codei='code-insiders'

alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'

# zsh-abbrプラグインを使用して元のコマンドに展開されるようにする
abbr add -S -qq ll='ls -la'
abbr add -S -qq dk='docker'
abbr add -S -qq dkc='docker compose'
abbr add -S -qq lzd='lazydocker'
abbr add -S -qq lzg='lazygit'
abbr add -S -qq codei='code-insiders'
abbr add -S -qq -g G='| grep'
abbr add -S -qq -g L='| less'
abbr add -S -qq -g H='| head'
abbr add -S -qq -g T='| tail'

# ==============================================================================
# 補完機能
# ==============================================================================

# 補完システムの初期化
autoload -Uz compinit && compinit

# 補完オプション
setopt auto_menu         # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_slash  # ディレクトリ名の補完で末尾に/を付加
setopt auto_param_keys   # カッコの対応などを自動的に補完
setopt list_types        # 補完候補一覧でファイルの種別を識別マーク表示
setopt list_packed       # 補完候補を詰めて表示
setopt magic_equal_subst # --prefix=/usrなどの=以降も補完

# 補完スタイルの設定
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %d%f'
zstyle ':completion:*:descriptions' format '%F{green}completing %B%d%b%f'

# ==============================================================================
# ツール設定 (fzf)
# ==============================================================================

# https://github.com/junegunn/fzf#setting-up-shell-integration
# https://github.com/junegunn/fzf/issues/3703#issuecomment-2675484142
FZF_VERSION="$(fzf --version | cut -d' ' -f1)"
if [[ "$(printf '%s\n' 0.48 "$FZF_VERSION" | sort -V | head -n1)" = 0.48 ]]; then
  # バージョン0.48.0以上の場合
  source <(fzf --zsh)
else
  # バージョン0.48.0未満の場合
  source <(curl -fsSL https://raw.githubusercontent.com/junegunn/fzf/refs/tags/$FZF_VERSION/shell/key-bindings.zsh)
fi

export FZF_DEFAULT_OPTS="--reverse --height 40%"

fzf-ghq-widget() {
  local repo=$(ghq list | fzf)
  if [ -n "$repo" ]; then
    BUFFER="cd $(ghq root)/$repo"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-ghq-widget
bindkey '^g' fzf-ghq-widget

# ==============================================================================
# ツール設定 (その他)
# ==============================================================================

# 1Password
# https://developer.1password.com/docs/cli/shell-plugins
# command -v op &>/dev/null && source "$HOME/.config/op/plugins.sh"

# docker
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit

# homebrew
command -v brew &>/dev/null && export HOMEBREW_NO_AUTO_UPDATE=1

# mise
eval "$(mise activate zsh)"
# aws-cli
# https://docs.aws.amazon.com/ja_jp/cli/v1/userguide/cli-configure-completion.html
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C aws_completer aws

# gibo
command -v gibo &>/dev/null && source <(gibo completion zsh)

# gh copilot (Set alias `ghce` and `ghcs`)
[[ -d "$HOME/.config/gh-copilot" ]] && eval "$(gh copilot alias -- zsh)"

# Kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C terraform terraform

# tmux
# # tmuxでセッションを作成したときに、tmux-loggingプラグインが自動でログを記録するようにする
# if [[ -n "$TMUX" ]]; then
#   TMUX_TOGGLE_LOGGING_SCRIPT="$HOME/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh"
#   if [[ -f "$TMUX_TOGGLE_LOGGING_SCRIPT" ]]; then
#     "$TMUX_TOGGLE_LOGGING_SCRIPT"
#   fi
# fi
