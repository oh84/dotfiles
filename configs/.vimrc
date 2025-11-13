" ==============================================================================
" defaults.vim の読み込み
" https://vim-jp.org/vimdoc-ja/starting.html#defaults.vim
" ==============================================================================

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" ==============================================================================
" プラグイン
" ==============================================================================

" vim-plugが存在しない場合は自動インストール
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" インストールするプラグイン
call plug#begin('~/.vim/plugged')
" Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'vim-jp/vimdoc-ja'
call plug#end()

" 未インストールのプラグインを自動インストール
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync
  \| source $MYVIMRC
  \| endif

" ==============================================================================
" キーバインド
" ==============================================================================

" leaderを<Space>に設定
let mapleader = "\<Space>"
" ESCをjjにバインド
inoremap <silent> jj <ESC>
" ESC連打で検索語のハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" ビジュアルモードでdで削除したときにヤンクしないようにする
vnoremap d "_d
" ビジュアルモードでcで削除したときにヤンクしないようにする
vnoremap c "_c
" ビジュアルモードでペーストしたときにヤンクしないようにする
vnoremap p "_dP

" ==============================================================================
" プラグインの設定
" ==============================================================================

" fzf
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>G :GFiles?<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>r :Rg<CR>

" lightline
" let g:lightline = { 'colorscheme': 'gruvbox' }
let g:lightline = {}

" nerdtree
noremap <silent> <C-e> :NERDTreeToggle<CR>
" 隠しファイルを表示（.gitなどを除く）
let NERDTreeShowHidden=1
let NERDTreeIgnore=[".git", ".DS_Store"]
" ファイル指定なしで起動した場合は最初からNERDTreeを開く
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in')
  \| NERDTree
  \| endif

" ==============================================================================
" 表示系
" ==============================================================================

" colorscheme gruvbox

" カラースキームが読み込まれた際に背景なしの設定に上書きする
" https://sy-base.com/myrobotics/vim/vim-transparent/
augroup TransparentBG
  autocmd!
  autocmd Colorscheme * highlight Normal ctermbg=none
  autocmd Colorscheme * highlight NonText ctermbg=none
  autocmd Colorscheme * highlight LineNr ctermbg=none
  autocmd Colorscheme * highlight Folded ctermbg=none
  autocmd Colorscheme * highlight EndOfBuffer ctermbg=none
augroup END

" 行番号を表示
set number
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable
" カーソルの種類を変更
if has('vim_starting')
  " ノーマルモード時に非点滅のブロックタイプのカーソル
  let &t_EI .= "\e[2 q"
  " 挿入モード時に非点滅の縦棒タイプのカーソル
  let &t_SI .= "\e[6 q"
  " 置換モード時に非点滅の下線タイプのカーソル
  let &t_SR .= "\e[4 q"
endif

" ==============================================================================
" Tab系
" ==============================================================================

" 不可視文字を可視化(タブが「▸-」と表示される)
" set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2

" ==============================================================================
" 検索系
" ==============================================================================

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch

" ==============================================================================
" その他
" ==============================================================================

" クリップボードをシステムと共有
set clipboard+=unnamed
" 文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" Undoの永続化
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  exe 'set undodir=' .. undo_path
  set undofile
endif
