" .vimrc
" Manabu Suezaki (manabu.szk@gmail.com)
"

" Don't try to be vi compatible
set nocompatible
filetype off

" Turn on syntax highlighting
syntax on

" スワップファイルを作成しない
set noswapfile
" バックアップファイルを作成しない
set nobackup 

" ファイルがVim外部で変更されたときに自動的に読み直す
set autoread

set background=dark
"colorscheme Tomorrow-Night

"ステータスラインに入力中のコマンドを表示
set showcmd

"ルーラーを表示する
set ruler
" Show line numbers
set number
set numberwidth=4

" カーソル移動が遅くなる場合はオフにすると早くなる
" https://eduncan911.com/software/fix-slow-scrolling-in-vim-and-neovim.html
"set cursorline
"set cursorcolumn

"ビープ音を消す
set vb t_vb=

" Show “invisible” characters
set list
set listchars=tab:»-,trail:-,eol:¬,extends:»,precedes:«,nbsp:%
" Help, NERDTreeバッファでは不可視文字を表示しない
autocmd FileType help setlocal nolist
autocmd FileType nerdtree setlocal nolist
autocmd FileType phpmanual setlocal nolist

"ステータスラインを常に表示
" Status bar
set laststatus=2
" set statusline=%<[%n]%m%r%h%w%f%m\ %{fugitive#statusline()}%=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}%y

"-------------------------------------------------------------------------------
" 文字コード
"-------------------------------------------------------------------------------
" 文字コードを指定(UTF-8)（保存時の文字コード）
set fenc=utf-8
" ファイル読み込み時の文字コード指定
set encoding=utf-8
" Vim Script内でマルチバイト文字を使うための設定
scriptencoding utf-8
" □や○文字が崩れる問題を解決
" iTerm2を使う場合は、Profiles->Text->Treat ambiguous-width characters as
" double widthをオンにする
set ambiwidth=double

"-------------------------------------------------------------------------------
" タブ・インデントの設定
"-------------------------------------------------------------------------------
" タブをスペースに変換する
set expandtab
" タブ文字の幅
set tabstop=4
" 改行時に前の行のインデントを継続する
set autoindent
"新しい行を作った時に高度な自動インデントを行う
set smartindent
" smartindentで増減するインデントのスペース幅
set shiftwidth=4

"-------------------------------------------------------------------------------
" 文字列検索
"-------------------------------------------------------------------------------
" インクリメンタルサーチ
set incsearch
" 検索パターンに大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索キーワードをハイライト表示する
set hlsearch

"-------------------------------------------------------------------------------
" カッコ・タグジャンプ
"-------------------------------------------------------------------------------
" カッコの対応関係を一瞬表示する
set showmatch
" Vimの「%」を拡張する
source $VIMRUNTIME/macros/matchit.vim

"-------------------------------------------------------------------------------
" マウス
"-------------------------------------------------------------------------------
" Enable use of the mouse for all modes
if has('mouse')
    set mouse=a
endif

"-------------------------------------------------------------------------------
" クリップボード
"-------------------------------------------------------------------------------
"set clipboard=unnamed,autoselect

"-------------------------------------------------------------------------------
" キーバインド
"-------------------------------------------------------------------------------
" この記事が参考になる
" Vimの生産性を高める12の方法
" https://postd.cc/how-to-boost-your-vim-productivity/
"
" let mapleader=","
let mapleader="\<Space>"
let maplocalleader=","

" ファイルを開く
nnoremap <Leader>o :CtrlP<CR>

" ファイルを保存する
nnoremap <Leader>w :w<CR>

" <Leader>pと<Leader>yでシステムのクリップボードにコピー＆ペーストする
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" ビジュアルラインモードに切り替える
nmap <Leader><Leader> V

" 前のバッファに切り替える
nnoremap <Leader><Tab> <C-^>


" 貼り付けたテキストの末尾に自動的に移動する
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Enterでファイルの末尾に移動する
" nnoremap <CR> G
" Backspaceでファイルの先頭に移動する
nnoremap <BS> gg

" 貼り付けたテキストを素早く選択する
noremap gV `[v`]

" カーソル下の1単語とヤンクしてきた文字列を置き換える
nnoremap ciy ciw<C-r>0<ESC>

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

"-------------------------------------------------------------------------------
" プラグイン
"-------------------------------------------------------------------------------

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

    " -------------------------------------------------
    " Lint Tool
    " -------------------------------------------------

    " ALE (Asynchronous Lint Engine)
    " 非同期コードチェック
    Plug 'w0rp/ale'

    " 左端のシンボルカラムを表示したままにする
    let g:ale_sign_column_always = 1
    let g:ale_linters = {
        \ 'php': ['phpcs', 'php']
        \}
    let g:ale_php_phpcs_executable = $HOME.'/.composer/vendor/bin/phpcs'
    let g:ale_php_phpcs_standard = 'PSR1,PSR2'
    let g:ale_php_phpcs_use_global = 1

    " -------------------------------------------------
    " Project
    " -------------------------------------------------

    " CtrlP.vim - 多機能セレクタ
    Plug 'kien/ctrlp.vim'
    let g:ctrlp_map = '<C-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_show_hidden=1
    " 拡張プラグイン・関数検索
    Plug 'tacahiroy/ctrlp-funky'
    " 拡張プラグイン・コマンド履歴検索
    Plug 'suy/vim-ctrlp-commandline'
    let g:ctrlp_extensions = ['funky', 'commandline']
    command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())
    let g:ctrlp_funky_matchtype='path'

    " ----------------------------------------
    " 見た目系
    " ----------------------------------------
    "  colorscheme
    Plug 'tomasr/molokai'
    Plug 'mhartington/oceanic-next'

    Plug 'freeo/vim-kalisi'
    Plug 'junegunn/seoul256.vim'

    " Plug 'itchyny/lightline.vim'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_powerline_fonts = 1
    " https://github.com/vim-airline/vim-airline/wiki/Screenshots
    let g:airline_theme = 'molokai'

    " -------------------------------------------------
    " IDE
    " -------------------------------------------------

    " Completion plugin
    " https://github.com/Shougo/deoplete.nvim
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    let g:deoplete#enable_at_startup=1
    " Plug 'Shougo/neocomplcache'
    " let g:neocomplcache_enable_at_startup=1
    " let g:neocomplcache_enable_smart_case=1

    " ↓Lazy Loadingしようとして、下のようにするとE580エラーになる
    " Plug 'scrooloose/nerdtree', {'on', 'NERDTreeToggle'}
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'jistr/vim-nerdtree-tabs'
    let g:nerdtree_tabs_open_on_console_startup=1

    "  devicons
    Plug 'ryanoasis/vim-devicons'
    " https://github.com/ryanoasis/vim-devicons/wiki/Extra-Configuration
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

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
    Plug 'Shougo/neomru.vim'
    Plug 'Shougo/neoyank.vim'
    Plug 'thinca/vim-unite-history'
    " unite.vimまとめ
    " https://qiita.com/hide/items/77b9c1b0f29577d60397#vimrc
    let g:unite_enable_start_insert=1
    " let g:unite_source_history_yank_enable=1
    let g:unite_source_file_mru_limit=200
    " yankの履歴
    nnoremap <silent> <leader>uy :<C-u>Unite history/yank<CR>
    nnoremap <silent> <leader>ub :<C-u>Unite buffer<CR>
    " カレントディレクトリを表示
    " nnoremap <silent> <leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> <leader>uf :<C-u>UniteWithProjectDir -buffer-name=files file<CR>
    " nnoremap <silent> <leader>uf :<C-u>Unite file<CR>
    nnoremap <silent> <leader>ur :<C-u>Unite -buffer-name=register register<CR>
    nnoremap <silent> <leader>uu :<C-u>Unite file_mru buffer<CR>

    " -------------------------------------------------
    " ファイルタイプ別
    " -------------------------------------------------
    Plug 'elixir-editors/vim-elixir'

    Plug 'posva/vim-vue'

    Plug 'mattn/emmet-vim'

    Plug 'jwalton512/vim-blade', {'for': 'blade'}

    Plug 'lervag/vimtex', {'for': 'tex'}

    Plug 'ekalinin/Dockerfile.vim', {'for': 'dockerfile'}

    " -------------------------------------------------
    " 編集系
    " -------------------------------------------------
    "  UltiSnip
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " Trigger configuration.
    " Do not use <tab> if you use YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsForwardTrigger="<C-b>"
    let g:UltiSnipsJumpBackwardTrigger="<C-z>"
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

    " " インデントを可視化する
    " Plug 'nathanaelkane/vim-indent-guides'
    " " 起動時に可視化を有効にする
    " let g:indent_guides_enable_on_vim_startup = 1
    " " 可視化領域のサイズ
    " let g:indent_guides_guide_size = 1
    " " 可視化を開始する階層
    " let g:indent_guides_start_level = 2
    " " 無効にするファイルタイプ
    " let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'ref-phpmanual']

    " vimをconcealオプションを有効にしてコンパイルしないと使えない
    Plug 'Yggdroot/indentLine'
    let g:indentLine_faster = 1
    nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>
    " let g:indentLine_setColors = 0
    " let g:indentLine_color_term = 239

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
" colorscheme
" ------------------------------------------------------------------------------
colorscheme OceanicNext
" if filereadable(expand('~/.vim/plugged/molokai/colors/molokai.vim'))
"     let g:molokai_original = 1
"     let g:rehash256 = 1
" endif
" colorscheme molokai

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

" vp doesn't replace paste buffer
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

