" no compatible with old vi
set nocompatible

inoremap jj <Esc>

" row number and cursorline
set number
set cursorline

" no annoying backup files 
set nobackup
set nowritebackup
set noswapfile

" search
set ignorecase
set smartcase
set incsearch
set hlsearch

" indent
set autoindent

set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set clipboard=unnamedplus

let mapleader=" "
let maplocalleader = " "
nnoremap <SPACE> <Nop>

nnoremap <leader>tn :tabnew<Enter> 
nnoremap <leader>tc :tabclose<Enter>
nnoremap <leader>tl :tabnext<Enter>
nnoremap <leader>th :tabprevious<Enter>

nnoremap <leader>r :source $MYVIMRC<Enter>

nnoremap <leader>ws :split<Enter>
nnoremap <leader>wv :vsplit<Enter>
nnoremap <leader>wh <C-w>h<Enter>
nnoremap <leader>wj <C-w>j<Enter>
nnoremap <leader>wk <C-w>k<Enter>
nnoremap <leader>wl <C-w>l<Enter>
nnoremap <leader>wc :q<Enter>

nnoremap <leader>e :e

set encoding=utf-8
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=-1

filetype on
filetype plugin on
filetype indent on

syntax enable

call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'lervag/vimtex'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'nvim-tree/nvim-web-devicons' " optional
Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

colorscheme onedark

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

lua << EOF
require("nvim-tree").setup()
EOF

nnoremap <leader>f :NvimTreeToggle<Enter>
