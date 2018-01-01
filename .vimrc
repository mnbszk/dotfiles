" Don't try to be vi compatible
set nocompatible
filetype off

" Turn on syntax highlighting
syntax on

set background=dark
"colorscheme Tomorrow-Night

set fenc=utf-8

set autoread

"ステータスラインにコマンドを表示
set showcmd

"ルーラーを表示する
set ruler
" Show line numbers
set number

set cursorline
set cursorcolumn

"対応するカッコを表示する
set showmatch

"タブ・インデントの設定
set expandtab
set tabstop=4
set shiftwidth=4

set autoindent
"新しい行を作った時に高度な自動インデントを行う
set smartindent

"ステータスラインを常に表示
" Status bar
set laststatus=2
set statusline=%<[%n]%m%r%h%w%f%m\ %{fugitive#statusline()}%=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}%y

" Enable use of the mouse for all modes
set mouse=a

"
"キーバインドの変更
"
noremap <C-j> <ESC>
noremap! <C-j> <ESC>
"方向キーはすべてESCキーに割り当て
"http://w.vmeta.jp/tdiary/20161026.html
inoremap <unique> <Right> <ESC>
inoremap <unique> <Left>  <ESC>
inoremap <unique> <Up>    <ESC>
inoremap <unique> <Down>  <ESC>

" ESCでIMEをオフにする
" http://nobeans.hatenablog.com/entry/20090211/1234326782
inoremap <ESC> <ESC>:iminsert=0<CR>

"
" Neobundle
" https://github.com/Shougo/neobundle.vim

" Note: Skip initialization for vim-tiny or vim small
if 0 | endif

if &compatible
    set nocompatible
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
"
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/Headlights'
"
NeoBundle 'mattn/emmet-vim'
" Color scheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'jwalton512/vim-blade'
" Git
NeoBundle 'tpope/vim-fugitive'
"
NeoBundle 'nathanaelkane/vim-indent-guides'
" 編集系
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'AndrewRadev/splitjoin.vim'
NeoBundle 'cohama/lexima.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Colorscheme
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
"set termguicolors

"
" NERDTree
" https://github.com/scrooloose/nerdtree
"

"起動時にNERDTreeを表示
"autocmd vimenter * NERDTree

"ファイル名が指定されてvimが起動した場合はNERDTreeを表示しない
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"ブックマークを初期表示　
let g:NERDTreeShowBookmarks=1

"NERDTreeを表示するコマンドを設定
map <silent><C-e> :NERDTreeToggle<CR>

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" https://github.com/scrooloose/nerdtree/issues/323
fun! s:MyNERDTreeSetting()
    fun! s:DoubleClickBehavior()
        if match(getline('.'), '▸' ) == -1 && match(getline('.'), '▾') == -1
            map <buffer> <2-LeftMouse> o
        else
            map <buffer> <2-LeftMouse> o
        endif
    endfun

    autocmd CursorMoved * call s:DoubleClickBehavior()
endfun

autocmd WinEnter * if &ft == 'nerdtree' | call s:MyNERDTreeSetting() | endif

"
" tcomment
"
call tcomment#DefineType('blade', '{{--%s--}}')

