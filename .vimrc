" Don't try to be vi compatible
set nocompatible
filetype off

" スワップファイルを作成しない
set noswapfile
" バックアップファイルを作成しない 
set nobackup 
" 

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
autocmd FileType phpmanual setlocal nolist

" 検索キーワードをハイライト表示する
set hlsearch

"ステータスラインを常に表示
" Status bar
set laststatus=2
" set statusline=%<[%n]%m%r%h%w%f%m\ %{fugitive#statusline()}%=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}%y

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

" 2018-05-28 vin-plug導入
if has('vim_starting')
    set rtp+=~/.vim/plugged/vim-plug
    if !isdirectory(expand('~/.vim/plugged/vim-plug'))
        echo 'install vim-plug...'
        call system('mkdir -p ~/.vim/plugged/vim-plug')
        call system('git clone https://github.coom/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
    endif
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
    Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}

    Plug 'Shougo/vimproc.vim'

    " ----------------------------------------
    " ドキュメント関連
    " ----------------------------------------
    " 日本語ヘルプ
    Plug 'vim-jp/vimdoc-ja'
    " 外部マニュアル
    Plug 'thinca/vim-ref'

    " -------------------------------------------------
    " Git
    " -------------------------------------------------
    " vim-fugitiveはvim-airlineより前に書くこと
    Plug 'tpope/vim-fugitive'
    "
    Plug 'mhinz/vim-signify'
    " Plug 'airblade/vim-gitgutter'
    " 未修正ファイルでもvim-gitgutter列を表示して差分表示で画面をガタガタさせない
    " https://budougumi0617.github.io/2018/06/20/setting-vim-gitgutter-column-shows-always/
    set signcolumn=yes

    Plug 'w0rp/ale'
    " 左端のシンボルカラムを表示したままにする
    let g:ale_sign_column_always = 1
    let g:ale_linters = {
        \ 'php': ['phpcs', 'php']
        \}
    let g:ale_php_phpcs_executable = $HOME.'/.composer/vendor/bin/phpcs'
    let g:ale_php_phpcs_standard = 'PSR1,PSR2'
    let g:ale_php_phpcs_use_global = 1

    " CtrlP.vim
    Plug 'kien/ctrlp.vim'
    let g:ctrlp_map = '<C-p>'
    let g:ctrlp_cmd = 'CtrlP'

    " ----------------------------------------
    " 見た目系
    " ----------------------------------------
    Plug 'tomasr/molokai'

    Plug 'freeo/vim-kalisi'
    Plug 'junegunn/seoul256.vim'

    " Plug 'itchyny/lightline.vim'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme = 'molokai'
    
    " -------------------------------------------------
    " IDE
    " -------------------------------------------------

    " ↓Lazy Loadingしようとして、下のようにするとE580エラーになる
    " Plug 'scrooloose/nerdtree', {'on', 'NERDTreeToggle'}
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    Plug 'vim-scripts/taglist.vim'
    let Tlist_Show_One_File = 1
    let Tlist_Use_Right_Window = 1
    let Tlist_Exit_OnlyWindow = 1

    Plug 'simeji/winresizer'
    let g:winresizer_enable = 1
    let g:winresizer_start_key = '<C-s>'
    let g:winresizer_gui_start_key = '<C-e>'

    " -------------------------------------------------
    " *nite
    " -------------------------------------------------
    " Plug 'Shougo/denite.nvim'
    Plug 'Shougo/unite.vim'
    " -------------------------------------------------
    " ファイルタイプ別
    " -------------------------------------------------
    Plug 'mattn/emmet-vim'

    Plug 'jwalton512/vim-blade', {'for': 'blade'}

    Plug 'lervag/vimtex', {'for': 'tex'}

    Plug 'ekalinin/Dockerfile.vim', {'for': 'dockerfile'}

    " -------------------------------------------------
    " 編集系
    " -------------------------------------------------
    " インデントを可視化する
    Plug 'nathanaelkane/vim-indent-guides'
    " 起動時に可視化を有効にする
    let g:indent_guides_enable_on_vim_startup = 1
    " 可視化領域のサイズ
    let g:indent_guides_guide_size = 1
    " 可視化を開始する階層
    let g:indent_guides_start_level = 2
    " 無効にするファイルタイプ
    let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'ref-phpmanual']

    " 括弧で囲む
    Plug 'tpope/vim-surround'

    " コメントアウト
    Plug 'tomtom/tcomment_vim'

    " 閉じ括弧自動補完
    Plug 'cohama/lexima.vim'
    " https://qiita.com/yami_beta/items/26995a5c382bd83ac38f
    inoremap <C-l> <C-g>U<Right>

    " -------------------------------------------------
    " 検索系
    " -------------------------------------------------
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-migemo.vim'

    Plug 'mhinz/vim-grepper'

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

    " -------------------------------------------------
    " その他
    " -------------------------------------------------

    " URLをブラウザで開く
    Plug 'tyru/open-browser.vim'
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)

    " URLをハイライト表示する
    Plug 'itchyny/vim-highlighturl'

    Plug 'vim-scripts/dbext.vim'
    let g:dbext_default_profile=""
    let g:dbext_default_type="PGSQL"
    let g:dbext_default_user="hip_app"
    let g:dbext_default_passwd="secret"
    let g:dbext_default_dbname="hip"
    let g:dbext_default_host="localhost"
    let g:dbext_default_port="54320"

call plug#end()

map <silent> <leader>T :WinResizerStartResize<CR>

" ------------------------------------------------------------------------------
" taglist.vim
" ------------------------------------------------------------------------------
map <silent> <leader>t :TlistToggle<CR>

" ------------------------------------------------------------------------------
" haya14busa/incsearch.vim
" ------------------------------------------------------------------------------
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backword)
map g/ <Plug>(incsearch-stay)

map m/ <Plug>(incsearch-migemo-/)
map m? <Plug>(incsearch-migemo-?)
map mg/ <Plug>(incsearch-migemo-stay)

" ------------------------------------------------------------------------------
" colorscheme molokai
" ------------------------------------------------------------------------------
if filereadable(expand('~/.vim/plugged/molokai/colors/molokai.vim'))
    let g:molokai_original = 1
    let g:rehash256 = 1
endif
colorscheme molokai

" ------------------------------------------------------------------------------
" tcomment_vim
" ------------------------------------------------------------------------------
if filereadable(expand('~/.vim/plugged/tcomment_vim/plugin/tcomment.vim'))
    call tcomment#type#Define('blade', '{{-- %s --}}')
endif

" ------------------------------------------------------------------------------
" Git
" ------------------------------------------------------------------------------
" vim-fugitiveの使い方の記事 https://www.mk-mode.com/octopress/2013/08/11/vim-install-fugitive/
if filereadable(expand('~/.vim/plugged/vim-fugitive/plugin/fugitive.vim'))
    " vim-fugitive キーマッピング
    " ref)
    " vimでキーマッピングする際に考えたほうがいいこと - http://deris.hatenablog.jp/entry/2013/05/02/192415
    " 最近導入した vim プラグイン をまとめる - http://karur4n.hatenablog.com/entry/2014/08/19/161320
    " fugitive.vim と tig による git 生活 - http://wakame.hatenablog.jp/entry/2017/05/03/222511
    " set custom commit options - https://github.com/tpope/vim-fugitive/issues/126
    " vimに自作コマンドを実装する - https://qiita.com/shimbaroid/items/f2ad60c203ccdff7da16
    " nnoremap [fugitive] <Nop>
    " nmap <Leader>g [fugitive]
    " nnoremap <Leader>gs :Gstatus<CR><C-w>T
    nnoremap <Leader>Gs :Gstatus<CR>
    " nnoremap <Leader>g [fugitive]p :Git push origin HEAD<CR>
    " GPG著名付きでコミットする
    " ref)
    " git(GitHub)でGPGを使った署名をおこなう - https://qiita.com/pontago/items/5867b6492e09c34084fe
    autocmd FileType gitcommit nnoremap <silent> <buffer> cs :<C-U>Gcommit -S<CR>
    autocmd FileType gitcommit nnoremap <silent> <buffer> csa :<C-U>Gcommit -S --amend<CR>
endif

" ------------------------------------------------------------------------------
" NERDTree
" https://github.com/scrooloose/nerdtree
" ------------------------------------------------------------------------------
if filereadable(expand('~/.vim/plugged/nerdtree/plugin/NERD_tree.vim'))
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1
    "ブックマークを初期表示　
    let g:NERDTreeShowBookmarks=1
    let NERDTreeIgnore = ['\~$', '\.swp$', '.DS_Store']

    "起動時にNERDTreeを表示
    "autocmd vimenter * NERDTree
    "ファイル名が指定されてvimが起動した場合はNERDTreeを表示しない
    autocmd StdinReadPre * let s:std_in = 1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    "NERDTreeを表示するコマンドを設定
    map <silent><C-e> :NERDTreeToggle<CR>

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

" ------------------------------------------------------------------------------
" vim-blade.vim
" ------------------------------------------------------------------------------
"syn keyword bladeKeyword @isset nextgroup=bladePhpParenBlock skipwhite containedin=ALLBUT, @bladeExempt
"syn keyword bladeKeyword @endisset containedin=ALLBUT, @bladeExempt
let g:blade_custom_directives = ['echoif', 'dump', 'dd', 'mix', 'style', 'script', 'inline', 'pushonce', 'routeis',
    \ 'routeisnot', 'instanceof', 'typeof', 'repeat', 'fa', 'data',
    \ 'zmdi',]

let g:blade_custom_directives_pairs = {
    \ 'echoif': 'endechoif',
    \ 'isset': 'endisset',
    \ 'istrue': 'endistrue',
    \ 'isfalse': 'endisfalse',
    \ 'isnull': 'endisnull',
    \ 'isnotnull': 'endisnotnull',
    \ }

" ------------------------------------------------------------------------------
" vim-ref
" ------------------------------------------------------------------------------
" vim-ref {{{
inoremap <silent><C-k> <C-o>:call<Space>ref#K('normal')<CR><ESC>
nmap <silent>K <Plug>(ref-keyword)
let g:ref_no_default_key_mappings = 1
let g:ref_cache_dir = $HOME.'/.vim/vim-ref/cache'
let g:ref_detect_filetype = {
            \     'php': 'phpmanual'
            \}
let g:ref_phpmanual_path = $HOME.'/.vim/vim-ref/php-chunked-xhtml'
let g:ref_use_cache = 1
let g:ref_use_vimproc = 1
" }}}

" ------------------------------------------------------------------------------
" vim-grepper
" ------------------------------------------------------------------------------
set grepprg=rg\ -H\ --no-heading\ --vimgrep
set grepformat=$f:$l:%c:%m

if filereadable(expand('~/.vim/plugged/vim-grepper/plugin/grepper.vim'))
    nnoremap <leader>g :Grepper -tool rg<cr>
    nnoremap <leader>G :Grepper -tool rg -buffers<cr>

    nmap gs <plug>(GrepperOperator)
    xmap gs <plug>(GrepperOperator)

    let g:grepper = {}
    let g:grepper.tool = ['rg', 'grep', 'git']
    let g:grepper.jump = 1
    let g:grepper.next_tool = '<leader>g'
    let g:grepper.simple_prompt = 1
    " let g:grepper.quickfix = 0

    " Search for the current word
    nnoremap <Leader>* :GrepperRg -cword -noprompt<CR>
    " Search for the current selection
    nmap gs <plug>(GrepperOperator)
    xmap gs <plug>(GrepperOperator)

    command! Todo :Grepper -tool rg -query '(TODO|FIXME)'
endif

" ------------------------------------------------------------------------------
" PHP lint
" http://kannokanno.hatenablog.com/entry/20120716/1342428418
" 2018-05/29 - w0rp/ale導入により、コメントアウト
" ------------------------------------------------------------------------------
" augroup PHP
"     autocmd!
"     autocmd FileType php set makeprg=php\ -l\ %
"     " php -l の構文チェックでエラーがなければ"No syntax errrs" の一行だけ出力
"     " される
"     autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif
" augroup END

"cd Projects/hip
