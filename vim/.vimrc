" Colorscheme
set t_Co=256
syntax enable
set bg=dark

filetype plugin indent on

" General settings
set number
set showcmd
set wildmenu

set nobackup nowritebackup
set noswapfile

" History
set history=200

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tabs
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set shiftwidth=4
set autoindent
set smartindent

" Lines
set wrap
set textwidth=80
set colorcolumn=81

" Backspace
set backspace=indent,eol,start

" Trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Encoding
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf8

" Remapping <ESC> to jk
inoremap jk <ESC>

" Leader key
let mapleader=" "

" Editing vimrc
nnoremap <Leader>ve :vsplit $MYVIMRC<cr>
nnoremap <Leader>vs :source $MYVIMRC<cr>:nohlsearch<cr>

" Make lowercase word under cursor
inoremap <C-d> <esc>viwui
nnoremap <C-d> viwu

" Make uppercase word under cursor
inoremap <C-u> <esc>viwUi
nnoremap <C-u> viwU

" Disable highlighting result of search
nnoremap <Leader>h :nohlsearch<cr>

" Moving through buffers
nnoremap <Leader>bn :bnext<cr>
nnoremap <Leader>bp :bprevious<cr>

" Windows
nnoremap <Leader>wv :vsplit<cr>
nnoremap <Leader>ws :split<cr>
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wl <C-W>l

" Tabs
nnoremap <Leader>tn :tabnew<cr>
nnoremap L :tabnext<cr>
nnoremap H :tabprevious<cr>

" Copy and paste to system clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>d "+d
vnoremap <Leader>p "+p
nnoremap <Leader>p "+p

" Changing keyboard layout
inoremap <C-s> <C-^>
nnoremap <C-s> i<C-^><esc>l

" For russian layout
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

" Statusline
set laststatus=2
set statusline=%f
set statusline+=,\ %l/%L
set statusline+=%=
set statusline+=%k

" Break line
nnoremap <NL> i<CR><ESC>
