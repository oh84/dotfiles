# zsh
brew 'zsh'
brew 'sheldon'
brew 'starship'

# tmux
brew 'tmux'
# brew 'tmux-mem-cpu-load'
# For tmux-logging
# https://github.com/tmux-plugins/tmux-logging#installing-ansifilter-recommended-for-osx-users
brew 'ansifilter'

# git
brew 'git'
brew 'gh'
brew 'ghq'
brew 'git-filter-repo'
# brew 'lefthook'
# tap 'jesseduffield/lazygit'; brew 'jesseduffield/lazygit/lazygit'
# tap 'simonwhitaker/tap'; brew 'simonwhitaker/tap/gibo'

# vim
brew 'vim'

# GNU commands
# https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
if OS.mac?
  brew 'coreutils'
  brew 'ed'
  brew 'findutils'
  brew 'gawk'
  brew 'gnu-sed'
  brew 'gnu-tar'
  brew 'grep'
  brew 'make'
  brew 'zip'
end

# Modern commands
# https://github.com/ibraheemdev/modern-unix
# brew 'bat'
# brew 'eza'
brew 'fd'
brew 'fzf'
brew 'jq'; brew 'jnv'
brew 'ripgrep'
brew 'yq'
# brew 'zoxide'

# Others
# brew 'azure-cli'
# brew 'bitwarden-cli'
# brew 'chrony'
# brew 'cloudflared'
# brew 'colima'
# brew 'duckdb'
# brew 'imagemagick'
# brew 'iproute2mac' if OS.mac?
# brew 'libyaml'
# brew 'mysql'
# brew 'openssl@1.1' if OS.mac? # 既にDeprecatedだが、古いRubyをビルドする場合に必要になる
# brew 'openssl@3'
# brew 'postgresql' if OS.mac? # Linuxだとpostinstallが失敗する
# brew 'tree'
# brew 'watch'
# brew 'watchman'
# brew 'wget'
# tap 'hashicorp/tap'; brew 'hashicorp/tap/terraform'
# tap 'idoavrah/homebrew'; brew 'idoavrah/homebrew/tftui'
# tap 'jesseduffield/lazydocker'; brew 'jesseduffield/lazydocker/lazydocker'

# 以降はGUIアプリ・フォント（cask）とMac App Storeアプリ（mas）
# CIには重すぎるため除外する（GitHub ActionsはCI=trueを自動設定する）
return unless OS.mac? && !ENV['CI']

# ==============================================================================
# cask
# ==============================================================================

cask '1password'
cask '1password-cli'
cask 'alt-tab'
cask 'antigravity'
cask 'appcleaner'
cask 'arc'
# cask 'bettertouchtool'
cask 'cursor'
cask 'dbeaver-community'
cask 'devtoys'
cask 'discord'
# cask 'docker'
cask 'dropbox'
cask 'drawio'
cask 'eset-cyber-security'
cask 'figma'
cask 'firefox'
cask 'ghostty'
cask 'google-chrome'
cask 'google-drive'
cask 'google-japanese-ime'
cask 'hammerspoon'
cask 'iterm2'
cask 'karabiner-elements'
cask 'keyboardcleantool'
cask 'lm-studio'
cask 'logi-options+'
cask 'lunar'
cask 'microsoft-auto-update'
cask 'microsoft-edge'
cask 'microsoft-office'
cask 'microsoft-teams'
cask 'miro'
cask 'notion'
cask 'obsidian'
# cask 'orbstack'
cask 'pdf-expert'
cask 'postman'
cask 'podman-desktop'
cask 'rancher'
cask 'raspberry-pi-imager'
cask 'raycast'
cask 'slack'
cask 'thaw'
cask 'utm'
cask 'visual-studio-code'
cask 'visual-studio-code@insiders'
cask 'windows-app'
cask 'zed'
cask 'zoom'

tap 'manaflow-ai/cmux'; cask 'manaflow-ai/cmux/cmux'

# Quick Look Plugins
# https://github.com/sindresorhus/quick-look-plugins
# https://webrandum.net/quick-look-plugins/
cask 'qlcolorcode'
cask 'qlmarkdown'
cask 'qlstephen'
cask 'quicklook-video' # 旧qlvideo
cask 'quicklook-csv'
cask 'quicklook-json'
cask 'suspicious-package'
cask 'syntax-highlight'
cask 'webpquicklook'

# Fonts
cask 'font-udev-gothic'
cask 'font-udev-gothic-nf'

# ==============================================================================
# mas
# ==============================================================================

# Mac App Store（要App Storeサインイン）
# 未サインインだとここで失敗するので、サインイン後にbootstrapを再実行する
brew 'mas'
mas 'Bitwarden', id: 1352778147
mas 'CotEditor', id: 1024640650
mas 'Kindle', id: 302584613
mas 'Monosnap', id: 540348655
mas 'Toggl Track: Hours & Time Log', id: 1291898086
mas 'Xcode', id: 497799835
