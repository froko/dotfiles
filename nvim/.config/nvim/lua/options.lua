vim.g.mapleader = ' '

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Enable auto indenting and set it to sapces
vim.opt.smartindent = true
vim.opt.shiftwidth = 2

-- Line wrapping
vim.opt.wrap = false

-- Enable incremental searching
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Enable ignorecase & smartcase for better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = 'yes'

-- Enable access to system clipboard
vim.opt.clipboard = 'unnamed,unnamedplus'

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Turn off swap files
vim.opt.swapfile = false
