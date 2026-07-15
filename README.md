# dotfiles

[mise bootstrap](https://mise.jdx.dev/bootstrap.html) で管理。

- `[dotfiles]` — 設定ファイルのシンボリックリンク（ソースは `configs/` 以下にホームと同じ構造でミラー）
- `[bootstrap.repos]` — tpm (tmux plugin manager) のクローン
- `[tools]`（`configs/.config/mise/config.toml`） — 言語ランタイム等
- `bootstrap` タスク（`mise-tasks/bootstrap`） — Homebrew のインストール、`brew bundle`、vim-plug など宣言的に書けないもの

## Setup

mise がインストールされていなくても `bin/mise`（[mise generate bootstrap](https://mise.jdx.dev/cli/generate/bootstrap.html) で生成）が pin されたバージョンをダウンロードして実行する。

```sh
ghq get oh84/dotfiles # または git clone https://github.com/oh84/dotfiles.git ~/ghq/github.com/oh84/dotfiles
cd ~/ghq/github.com/oh84/dotfiles
./bin/mise trust
./bin/mise bootstrap --yes
```

※ `dotfiles.root` を ghq のパスに固定しているため、クローン先は `~/ghq/github.com/oh84/dotfiles` にすること。

再実行は安全（収束済みの項目はスキップされる）。既存ファイルと衝突する場合は `--force-dotfiles` で上書きできる。

## 日常操作

```sh
mise dotfiles status            # リンク状態の確認
mise dotfiles apply             # リンクの適用
mise dotfiles add ~/.foorc      # 新しい設定ファイルを管理下に追加（configs/へ取り込み）
mise bootstrap --dry-run        # 何が実行されるかの確認
```

## Lint

```sh
mise run lint          # すべて実行
mise run lint:shell    # shellcheck + shfmt
mise run lint:actions  # actionlint + zizmor + ghalint + pinact
mise run lint:toml     # taplo
mise run lint:json     # jq
```

リンターは `mise.toml` の `[tools]` で管理している（CI・ローカル共通）。

コミット時は次の2段階で自動チェックされる:

1. グローバルフック（`~/.config/git/hooks/pre-commit`） — secretlint
2. リポジトリローカルフック（`.git/hooks/pre-commit`、グローバルフックから連鎖） — `mise run pre-commit`（= lint 一式）

ローカルフックは `mise bootstrap` 時に `mise generate git-pre-commit` で生成される。手動で生成し直す場合:

```sh
mise generate git-pre-commit --write --task=pre-commit
```

## bin/mise の更新

mise のバージョンを上げるときは bootstrap スクリプトを再生成する。

```sh
mise generate bootstrap --write bin/mise
```
