syntax on

" Basic settings
set nocompatible
set encoding=UTF-8
set hidden
set belloff=all
set mouse=a
set scrolloff=10
let mapleader=' '

" Appearance
set cursorline
set number relativenumber
set nowrap
set showmatch
set termguicolors

" Cursor style
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

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
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

" Buffers
nnoremap bj :bprev<CR>
nnoremap bk :bnext<CR>
nnoremap <Space>bb :bd<CR>
nnoremap <Space>ba :%bd\|e#\|bd#<CR>
nnoremap <Space>bA :%bd<CR>
nnoremap <Space><Space> :ls<CR>:b<Space>

" Windows
nnoremap <Leader>ws <C-w>v
nnoremap <Leader>wh <C-w>n
nnoremap <Leader>ww <C-w>c

" Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Replace in buffer
nnoremap <Leader>s :%s//gI<Left><Left><Left>

" Move block
xnoremap <Down> :move'>+<CR>gv=gv
xnoremap <Up> :move-2<CR>gv=gv

" Netrw
let g:netrw_banner = 0
let g:netrw_winsize = 25
nnoremap \ :Lex<CR>

" Autocommands
autocmd bufwritepre * %s/\s\+$//e " remove trailing white space on save
autocmd vimresized * wincmd =     " auto-resize splits when vim gets resized

" Plugins
call plug#begin()
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'vim-airline/vim-airline'
  Plug 'tribela/vim-transparent'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tpope/vim-surround'
  Plug 'easymotion/vim-easymotion'
call plug#end()

" Color scheme
colorscheme catppuccin_mocha
let g:airline_theme = 'catppuccin_mocha'
"
" Easy Motion
let g:EasyMotion_smartcase = 1
nnoremap s <Plug>(easymotion-s2)
