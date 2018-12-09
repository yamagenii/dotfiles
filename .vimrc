"""""""""""""""""""""""""""""""""""""""
"エンコード
"""""""""""""""""""""""""""""""""""""""
set encoding=utf-8 "エンコード設定
scriptencoding utf-8 "スクリプトエンコード


"""""""""""""""""""""""""""""""""""""""
"文字コード
"""""""""""""""""""""""""""""""""""""""
set fileencoding=utf-8 "保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コード自動判定
set fileformats=unix,dos,mac " 改行コードの自動判別　左優先
set ambiwidth=double " 文字の崩れを修正
set nf=hex " インクリメントディクリメント16進数に

if v:progname =~? "evim"
  finish
endif


"""""""""""""""""""""""""""""""""""""""
"NeoBundle
"""""""""""""""""""""""""""""""""""""""

if has('vim_starting')
       "初回起動時のみruntimepathにneobundleのパスを指定する
       set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" NeoBundleを初期化
call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするプラグインをここに記述
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle "thinca/vim-quickrun"
NeoBundle "Shougo/vimproc"
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'cohama/vim-insert-linenr'

" Rust
NeoBundle 'racer-rust/vim-racer'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'scrooloose/syntastic'
let g:racer_cmd = "$HOME/.cargo/bin/racer"
let g:rustfmt_autosave = 1
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['rust'] }
let g:syntastic_rust_checkers = ['rustc', 'cargo']


" jsxシンタックスハイライト
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
call neobundle#end()

filetype plugin indent on

" NeoBundleCheck を走らせ起動時に未インストールプラグインをインストールする
NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""
" カラースキーム
"""""""""""""""""""""""""""""""""""""""
" molokai
"if neobundle#is_installed('molokai')
"    colorscheme molokai
"endif
" hybrid
"if neobundle#is_installed('vim-hybrid')
"    colorscheme hybrid
"    set background=dark 
"endif
" jellybeans
if neobundle#is_installed('jellybeans.vim')
    colorscheme jellybeans
endif

set t_Co=256
syntax enable


"""""""""""""""""""""""""""""""""""""""
" ステータスライン
"""""""""""""""""""""""""""""""""""""""
set laststatus=2 "ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd "売ったコマンドをステータスラインに表示
set ruler " ステータスラインの右側にコマンドを表示


"""""""""""""""""""""""""""""""""""""""
" コマンドモード
"""""""""""""""""""""""""""""""""""""""
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド数
set noswapfile


"""""""""""""""""""""""""""""""""""""""
" タブインデント
"""""""""""""""""""""""""""""""""""""""

set autoindent "改行時にインデントを引き継いで改行する
set shiftwidth=4 "インデントにつかわれる空白の数
set softtabstop=4 "<Tab>押下時の空白数
set expandtab "<Tab>押下時に<Tab>ではなく、ホワイトスペースを挿入する
set tabstop=4 "<Tab>が対応する空白の数
set smartindent "改行時にシンタックスでインデントの挿入を決める


""""""""""""""""""""""""""""""""""""""
" 文字列検索
"""""""""""""""""""""""""""""""""""""""
set incsearch " インクリメンタルサーチ
set ignorecase " 検索に小文字大文字区別しない
set smartcase " 検索パターンに大文字を含む場合は区別
set hlsearch " 検索をハイライト

"２回esc を押したら検索のハイライトをヤメる
nmap <Esc><Esc> :nohlsearch<CR><Esc>

""""""""""""""""""""""""""""""""""""""
" カーソル
"""""""""""""""""""""""""""""""""""""""

set mouse=a " マウスの使用
set nocompatible
set whichwrap=b,s,h,l,<,>,[,],~ "カーソルが行末にきたら折り返す
set number
set cursorline "カーソルラインの表示
set cursorcolumn "列を強調表示
nmap j gj
nmap k gk
nmap <down> gj
nmap <up> gk
set nowrap " 端で折り返さない
set backspace=indent,eol,start


""""""""""""""""""""""""""""""""""""""
" カッコ　タグジャンプ
"""""""""""""""""""""""""""""""""""""""
set showmatch " カッコの対応関係の表示
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する


""""""""""""""""""""""""""""""""""""""
" ペースト設定
"""""""""""""""""""""""""""""""""""""""

set clipboard+=unnamed
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

""""""""""""""""""""""""""""""""""""""
" キーマッピング
"""""""""""""""""""""""""""""""""""""""

"インサートモードの時に C-j でノーマルモードに戻る
imap <C-j> <esc>
"[ って打ったら [] って入力されてしかも括弧の中にいる(以下同様)
imap [ []<left>
imap ( ()<left>
imap { {}<left>

""""""""""""""""""""""""""""""""""""""
" unite.vimの設定
"""""""""""""""""""""""""""""""""""""""
noremap <C-U><C-F> :Unite -buffer-name=file file<CR> " ファイル一覧
noremap <C-U><C-R> :Unite file_mru<CR> " 最近使ったファイル一覧
au FileType unite nnoremap <silent> <buffer> <expr> <C-i> unite#do_action('split') " ウィンドウを分割して開く
au FileType unite inoremap <silent> <buffer> <expr> <C-i> unite#do_action('split')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" NERDTree の設定
nnoremap :tree :NERDTreeToggle

"  自動syntasticチェック
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=2
"let g:syntastic_mode_map = {'mode': 'passive'} 
"augroup AutoSyntastic
"    autocmd!
"    autocmd InsertLeave,TextChanged * call s:syntastic() 
"augroup END
"function! s:syntastic()
"    w
"    SyntasticCheck
"endfunction
"" jsのシンタックス
"let g:jsx_ext_required = 0
"let g:syntastic_markdown_checkers = ['textlint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" TODO:うざいので作成時は削除
"
let g:syntastic_markdown_checkers = ['textlint']
let g:syntastic_text_checkers = ['textlint']


"ユーザ側で定義した g:quickrun_config
let g:quickrun_config = get(g:, 'quickrun_config', {})


" この関数に g:quickrun_config を渡す
" この関数で g:quickrun_config
" にシンタックスチェックを行うための設定を追加する
" 関数を呼び出すタイミングはユーザの g:quickrun_config 設定後
call watchdogs#setup(g:quickrun_config)

" 書き込み後にシンタックスチェックを行う
let g:watchdogs_check_BufWritePost_enable = 1

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.


if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.


" Only do this part when compiled with support for autocommands.
if has("autocmd")


  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else


endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
