"Last Change: 29/05/2018
"Maintainer: Watanabe Taichi < weasel.wt@outlook.com>

" ### Initialization ### {{{
"My autocmd group
augroup MyAutoCmd
	autocmd!
augroup END

set all&

"viとの互換ではなくvimの機能をフルに発揮できるようにする。
set nocompatible

" 日本語ヘルプ
set helplang=en,ja

"vim自体が使用する文字エンコーディング
set encoding=utf-8

" must be set with multibyte strings
scriptencoding=utf-8

" enable syntax higlight
syntax on
set synmaxcol=400

" enable indent plugin each filetype
filetype plugin indent on

" ### terminal ### {{{
if has('terminal')
	set termguicolors
endif
"}}}
"}}}

" ### encoding ### {{{
"文字コードの自動認識
set fileencodings=utf-8,utf-16,cp932,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
autocmd BufEnter * setlocal bomb?

"ファイルに保存される文字エンコーディング
set fileencoding=utf-8

"改行文字
set fileformat=unix
set ambiwidth=double "全角文字が半角で表示される問題を解消

" テキスト挿入中の自動折り返しを日本語に対応させる
" auto commet off
augroup auto_comment__off
	autocmd!
	autocmd BufEnter * setlocal formatoptions=tcqmM
augroup END
"}}}

" ### Indent ###{{{
set autoindent "新しい行のインデントを継続する

"set expandtab "tab to space
set tabstop=4 "画面上でタブ文字の占める幅
set shiftwidth=4 "自動インデントでずれる幅
set smartindent "高度なインデント

"折り返しの際にインデントを考慮
if exists('+breakindent')
	set breakindent
endif
" }}}

" ### search ### {{{
"インクリメンタル検索を有効にする
set incsearch

"大文字小文字を無視
set ignorecase

"大文字が入力されたら大文字小文字を区別する
set smartcase
" }}}

" ### Buffer ### {{{
" if miss to guess filetype
autocmd MyAutoCmd BufWritePost *
			\ if &filetype ==# '' && exists('b:ftdetect') |
			\ unlet! b:ftdetect |
			\ filetype detect |
			\ endif

set cursorline
"マウスとの連携機能をオフにする
set mouse=

"vimの無名レジスタとOSのクリップボードを連携させる
if has('clipboard')
	set clipboard=unnamed
endif

"ファイル内容が変更されると自動読み込みする
set autoread

"スワップファイルを作成しない
set noswapfile

"undoの記録を残す
set undofile undodir=$HOME/.vim/.vimundo

"バックアップファイルの出力先を変更
set nobackup
"set backupdir=$HOME/.vim/temp

"no viminfo file
set viminfo+=n

"windows上でもunix形式のend-of-lineを使う
set viewoptions=unix

"固定文句を入れる
autocmd MyAutoCmd BufNewFile *.html :0r $HOME/.vim/template/t_html.html
autocmd MyAutoCmd BufNewFile *.tex :0r $HOME/.vim/template/t_tex.tex

set t_Co=256
"コマンドライ=2
set cmdheight=3

"ステータスラインを表示
set laststatus=2
set statusline=%F%r%h%=
set ruler " add cursor line location in right of status line

"不可視文字を不可視化
set nolist

"最低でも上下に表示する行数
set scrolloff=5

"入力したコマンドを画面下に表示
set showcmd

"自動折り返ししない
set textwidth=0

"長い行を@にさせない
set display=lastline

" disable conceal for tex
let g:tex_conceal=''
autocmd MyAutoCmd BufRead,BufNewFile *.tex :set foldmethod=marker

"ステータスラインを表示
set laststatus=2
set statusline=%F%r%h%=
set ruler " add cursor line location in right of status line

"ファイル名内の'\'をスラッシュに置換する
set viewoptions+=slash

autocmd MyAutoCmd BufWritePre * call s:remove_unnecessary_space()

function! s:remove_unnecessary_space()
	" delete last spaces
	%s/\s\+$//ge

	" delete last blank lines
	while getline('$') == ""
		$delete _
	endwhile
endfunction


"colorscheme
colorscheme iceberg

set nohlsearch
if v:version > 800
	set nrformats=alpha,hex,bin
endif

" faster redraw
set lazyredraw
set ttyfast
"}}}

" ### completion ### {{{
"入力補完機能を有効化
set wildmenu wildmode=list:full

"spelling補完 on <C-x><C-s>
set spelllang+=cjk "日本語をスペルチェックの対象 から除外する

"dictionary Complete
autocmd MyAutoCmd BufRead,BufNewFile *.js :set dictionary=$HOME/.vim/dict/javascript.dict
autocmd MyAutoCmd BufRead,BufNewFile *.html :set dictionary=$HOME/.vim/dict/html.dict
autocmd MyAutoCmd BufRead,BufNewFile *.css :set dictionary=$HOME/.vim/dict/css.dict
autocmd MyAutoCmd BufRead,BufNewFile *.tex :set dictionary=$HOME/.vim/dict/tex.dict
autocmd MyAutoCmd BufRead,BufNewFile *.py :set dictionary=$HOME/.vim/dict/python.dict
autocmd MyAutoCmd BufRead,BufNewFile *.cpp :set dictionary=$HOME/.vim/dict/cpp.dict
autocmd MyAutoCmd BufRead,BufNewFile *.c :set dictionary=$HOME/.vim/dict/clang.dict
autocmd MyAutoCmd BufRead,BufNewFile *.rb :set dictionary=$HOME/.vim/dict/ruby.dict
autocmd MyAutoCmd BufRead,BufNewFile *.php :set dictionary=$HOME/.vim/dict/php.dict

"Enable omni completion
autocmd MyAutoCmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd MyAutoCmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd MyAutoCmd FileType python setlocal omnifunc=python3complete#Complete
autocmd MyAutoCmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd MyAutoCmd FileType xml setlocal omnifunc=ccomplete#Complete

"syntax complete
autocmd MyAutoCmd FileType *
			\    if &l:omnifunc == ''
			\ |    setlocal omnifunc=syntaxcomplete#Complete
			\ |  endif

" }}}

" ### Command ### {{{
"コマンドライン補完on
set wildmenu

"コマンドライン補完の方法
set wildmode=longest:full,full

"コマンド履歴の保存数
set history=2000

"いろんなコマンドの後にカーソルを先頭に移動させない
set nostartofline

" key mapping
" change Leader key to Space key
let mapleader = "\<Space>"

" Load current file as vimrc
nnoremap <silent> <F5> :<C-u>call <SID>source_script('%')<CR>

" return command line history
cnoremap <C-n> <Down>
" proceed commadn line history
cnoremap <C-p> <Up>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" disable save and close
nnoremap ZZ <Nop>
" disable not to save and close
nnoremap ZQ <Nop>

" }}}

" ### Load local vimrc ### {{{
augroup vimrc-local
	autocmd!
	autocmd BufNewFile,BufRead * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
	let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
	for i in reverse(filter(files, 'filereadable(v:val)'))
		source `=i`
	endfor
endfunction
" }}}

" ### plugin ### {{{
" match {{{
set showmatch
source $VIMRUNTIME/macros/matchit.vim " expand % command
" }}}

" tagbar.vim
let g:tagbar_width = 30

" code checker plugin
" ale {{{
if has('job') && has('channel') && has('timers')
	let g:ale_sign_column_always = 1

	" format message
	let g:ale_echo_msg_error_str = 'E'
	let g:ale_echo_msg_warning_str = 'W'
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

	"move error mapping
	nmap <silent> <C-k> <plug>(ale_next_wrap)

	" check at :w
	let g:ale_lint_on_save = 1
	let g:ale_lint_on_text_changed = 1
	"check at open file
	let g:ale_lint_on_enter = 1

	" use QuickFix instead of location list
	let g:ale_set_loclist = 0
	let g:ale_set_quickfix = 1

	" set linter
	let g:ale_linters = {
				\ 'javascript' : ['eslint'],
				\ 'html' : ['cHTMLHint'],
				\ 'css' : ['csslint'],
				\ 'latex' : ['chktex'],
				\ 'c' : ['gcc'],
				\ 'cpp' : ['gcc'],
				\ }
	autocmd BufNewFile,BufRead *.cpp call s:cpplinter()
	autocmd BufNewFile,BufRead *.c call s:clanglinter()

	function! s:cpplinter()
		let g:ale_cpp_gcc_options="-std=c++17 -Wall"
	endfunction

	function! s:clanglinter()
		let g:ale_c_gcc_options="-std=c99 -Wall"
	endfunction

	" set fixer
	nnoremap <space>= :ALEFix<CR>
endif
" }}}

" neocomplete {{{
" plugin key-mappings.
" Enable snipMate compatibility feature.
if v:version > 704
	let g:neosnippet#enable_snipmate_compatibility = 1

	" Tell Neosnippet about the other snippets
	let g:neosnippet#snippets_directory='~/.vim/snippets/'
	imap <C-k> <plug>(neosnippet_expand_or_jump)
	smap <C-k> <plug>(neosnippet_expand_or_jump)
	xmap <C-k> <plug>(neosnippet_expand_target)
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
				\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

	if has('conceal')
		set conceallevel=2 concealcursor=niv
	endif
endif
" }}}
" Align.vim {{{
let g:Align_xstrlen = 3
" }
"}}}

set secure
