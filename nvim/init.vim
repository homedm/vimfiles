" encoding setting
set encoding=utf-8                     " バッファ内で扱う文字コード
set fileencoding=utf-8                 " 書き込み時UTF-8出力
set fileencodings=utf-8,cp932,sjis          " 読み込み時UTF-8, CP932, Shift_JISの順で自動判別
set fileformats=unix,dos,mac

" editor setting
set number                             " 行番号表示
set showcmd                            " 入力中のコマンドをステータスに表示
set splitbelow                         " 水平分割時に下に表示
set splitright                         " 縦分割時を右に表示
set noequalalways                      " 分割時に自動調整を無効化
set wildmenu                           " コマンドモードの補完
set smartindent                        " スマートインデントを行う
set list
set listchars=tab:>>,trail:_,nbsp:+
" temporary file setting
set noundofile                         " undofileを作らない
set noswapfile                         " swapfileを作らない
" cursor setting
set ruler                              " カーソルの位置表示
set cursorline                         " カーソルハイライト
" tab setting
set expandtab                          " tabを複数のspaceに置き換え
set tabstop=4                          " tabは半角4文字
set shiftwidth=4                       " tabの幅

set wildmenu wildmode=longest:full
set wildignore+=*.o,*.obj,*.class,*.exe,*.jpg,*.png,*.jar,*.apk

" terminal mode
set shell=nyagos
set shellcmdflag=-c
set shellxquote=
set shellxescape=
set shellslash

call plug#begin('~/.config/nvim/plugged')
" Language Server Protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'plan9-for-vimspace/acme.vim'

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'
call plug#end()

nmap <silent> <space><space> :<C-u>CocList<cr>
nmap <silent> <space>h :<C-u>call CocAction('doHover')<cr>
nmap <silent> <space>df <Plug>(coc-definition)
nmap <silent> <space>rf <Plug>(coc-references)
nmap <silent> <space>rn <Plug>(coc-rename)
nmap <silent> <space>fmt <Plug>(coc-format)

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
