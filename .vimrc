" Don't try to be vi compatible
set nocompatible
filetype off

" Turn on syntax highlighting
syntax on

set background=dark
"colorscheme Tomorrow-Night

" 文字コードを指定(UTF-8)
set fenc=utf-8

set autoread

"ステータスラインにコマンドを表示
set showcmd

"ルーラーを表示する
set ruler
" Show line numbers
set number
set numberwidth=4

set cursorline
set cursorcolumn


set showmatch

"タブ・インデントの設定
set expandtab
set tabstop=4
set shiftwidth=4

set autoindent
"新しい行を作った時に高度な自動インデントを行う
set smartindent

"ビープ音を消す
set vb t_vb=

" Show “invisible” characters
set listchars=tab:»-,trail:-,eol:¬,extends:»,precedes:«,nbsp:%
set list
" Help, NERDTreeバッファでは不可視文字を表示しない
autocmd FileType help setlocal nolist
autocmd FileType nerdtree setlocal nolist

"ステータスラインを常に表示
" Status bar
set laststatus=2
set statusline=%<[%n]%m%r%h%w%f%m\ %{fugitive#statusline()}%=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}%y

" Enable use of the mouse for all modes
set mouse=a

"
"キーバインドの変更
"
let mapleader=","

" nnoremap    <C-u>   g~iw
noremap     <C-j>   <ESC>
noremap!    <C-j>   <ESC>

" Edit my Vimrc file
nnoremap    <leader>ev  :split $MYVIMRC<CR>
" Source my Vimrc file
nnoremap    <leader>sv  :source $MYVIMRC<CR>

"方向キーはすべてESCキーに割り当て
"http://w.vmeta.jp/tdiary/20161026.html
"inoremap <unique> <Right> <ESC>
"inoremap <unique> <Left>  <ESC>
"inoremap <unique> <Up>    <ESC>
"inoremap <unique> <Down>  <ESC>

" ESCでIMEをオフにする
" http://nobeans.hatenablog.com/entry/20090211/1234326782
" :set noimdisable としておくこと
" inoremap <ESC> <ESC>:set iminsert=0<CR>

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
"
NeoBundle 'Shougo/unite.vim'

NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'kien/ctrlp.vim'
"
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/Headlights'
"
NeoBundle 'mattn/emmet-vim'
" Color scheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'jwalton512/vim-blade'

" Tex
NeoBundle 'lervag/vimtex'

"syn keyword bladeKeyword @isset nextgroup=bladePhpParenBlock skipwhite containedin=ALLBUT, @bladeExempt
"syn keyword bladeKeyword @endisset containedin=ALLBUT, @bladeExempt
let g:blade_custom_directives = ['dump', 'dd', 'mix', 'style', 'script', 'inline', 'pushonce', 'routeis',
    \ 'routeisnot', 'instanceof', 'typeof', 'repeat', 'fa', 'data',
    \ ]

let g:blade_custom_directives_pairs = {
    \ 'isset': 'endisset',
    \ 'istrue': 'endistrue',
    \ 'isfalse': 'endisfalse',
    \ 'isnull': 'endisnull',
    \ 'isnotnull': 'endisnotnull',
    \ }

" Git
" vim-fugitiveの使い方の記事 https://www.mk-mode.com/octopress/2013/08/11/vim-install-fugitive/
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
let g:gitgutter_highlight_lines=1

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
if neobundle#is_installed('molokai')
    colorscheme molokai
    let g:molokai_original = 1
    let g:rehash256 = 1
endif
"set termguicolors

"
" NERDTree
" https://github.com/scrooloose/nerdtree
"
if neobundle#is_installed('nerdtree')
    "起動時にNERDTreeを表示
    "autocmd vimenter * NERDTree

    "ファイル名が指定されてvimが起動した場合はNERDTreeを表示しない
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    "ブックマークを初期表示　
    let g:NERDTreeShowBookmarks=1

    "NERDTreeを表示するコマンドを設定
    map <silent><C-e> :NERDTreeToggle<CR>

    
    let NERDTreeIgnore = ['\~$', '\.swp$', '.DS_Store']
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
endif

"
" tcomment
"
if neobundle#is_installed('tcomment_vim')
    call tcomment#DefineType('blade', '{{-- %s --}}')
endif

"
" lightline
"
set noshowmode

" lightline.vimをカスタマイズする
" http://leafcage.hateblo.jp/entry/2013/10/21/lightlinevim-customize

" 作者が教える！ lightline.vimの導入・設定方法！ 〜 初級編 - インストールしよう
" http://itchyny.hatenablog.com/entry/20130828/1377653592
let g:lightline = {
        \ 'colorscheme': 'powerline',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'bufnum', 'readonly', 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" コンポーネント定義
let g:lightline.component = {}
let g:lightline.component.winbufnum = '%n{repeat(",", winnr())}%<'

"
" CtrlP.vim
"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


" http://kannokanno.hatenablog.com/entry/20120716/1342428418
augroup PHP
    autocmd!
    autocmd FileType php set makeprg=php\ -l\ %
    " php -l の構文チェックでエラーがなければ"No syntax errors" の一行だけ出力
    " される
    autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif
augroup END

cd Projects/hip
