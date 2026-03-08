local inoremap = require('utils').inoremap
local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

-- Set <space> as the leader key
vim.g.mapleader = ' '

-- Core
inoremap('jk', '<Esc>')
nnoremap('<leader>r', ':e!<CR>', { desc = 'Reload file' })
nnoremap('<leader>ts', ':setlocal spell!<CR>', { desc = 'Toggle Spellcheck' })

-- Navigation
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-f>', '<C-f>zz')
nnoremap('<C-b>', '<C-b>zz')

-- Buffers
nnoremap('<leader>bb', ':bp<bar>sp<bar>bn<bar>bd<CR>', { desc = 'Delete buffer' })
nnoremap('<leader>ba', ':%bd<CR>', { desc = 'Delete all buffers' })
nnoremap('<leader>bA', ':%bd|e#|bd#<CR>', { desc = 'Delete all buffers but this' })
nnoremap('bj', ':bprev<CR>')
nnoremap('bk', ':bnext<CR>')

-- Move block
vnoremap('<Down>', ":m '>+1<CR>gv=gv")
vnoremap('<Up>', ":m '<-2<CR>gv=gv")

-- Replace in file
nnoremap('<Leader>s', ':%s//gI<Left><Left><Left>', { desc = 'Search and Replace in file' })
