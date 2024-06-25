syntax on

" Basic settings
set nocompatible
set encoding=UTF-8
set hidden
set belloff=all
set mouse=a
let mapleader=' '

" Appearance
set cursorline
set number relativenumber
set nowrap
set showmatch
set termguicolors

" Clipboard settings
set clipboard+=unnamed
set go+=a

" Backup settings
set noswapfile
set nobackup
set nowritebackup

" Tab settings
set smarttab
set smartindent
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" Auto completion
set wildmenu
set wildmode=longest,list,full

" Fix splitting
set splitbelow splitright

" Standard bindings
inoremap jk <Esc>
nnoremap L $
nnoremap H ^

" Buffers
nnoremap bj :bprev<CR>
nnoremap bk :bnext<CR>
nnoremap bd :bd<CR>
nnoremap bD :bd!<CR>
nnoremap <Space><Space> :ls<CR>:b<Space>

" Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap ss <C-w>v
nnoremap sS <C-w>n
nnoremap sd <C-w>c

" Alias replace all to S
nnoremap <Leader>mh :%s//gI<Left><Left><Left>

" Move block
xnoremap <Down> :move'>+<CR>gv=gv
xnoremap <Up> :move-2<CR>gv=gv

" Netrw
let g:netrw_banner = 0
let g:netrw_winsize = 25
nnoremap <Leader>e :Lex<CR>

" Autocommands
autocmd bufwritepre * %s/\s\+$//e " remove trailing white space on save
autocmd vimresized * wincmd =     " auto-resize splits when vim gets resized

" Plugins
call plug#begin()
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'vim-airline/vim-airline'
  Plug 'tribela/vim-transparent'
  Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" Color scheme
colorscheme catppuccin_mocha
let g:airline_theme = 'catppuccin_mocha'
