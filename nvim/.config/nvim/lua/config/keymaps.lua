local inoremap = require('utils').inoremap
local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

-- Set <space> as the leader key
vim.g.mapleader = ' '

-- Core
inoremap('jk', '<Esc>')
nnoremap('<leader>r', ':e!<CR>', { desc = '[R]eload file' })

-- Navigation
nnoremap('L', '$')
nnoremap('H', '^')
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-f>', '<C-f>zz')
nnoremap('<C-b>', '<C-b>zz')

-- Windows
nnoremap('<leader>ws', ':vsplit<CR>', { desc = '[W]indow [S]plit (vertically)' })
nnoremap('<leader>wh', ':split<CR>', { desc = '[W]indow Split ([H]orizontally)' })
nnoremap('<leader>ww', ':close<CR>', { desc = '[W]indow Close' })

-- Buffers
nnoremap('<leader>bb', ':bd<CR>', { desc = '[B]uffer delete' })
nnoremap('<leader>ba', ':%bd<CR>', { desc = '[B]uffer delete [A]ll' })
nnoremap('<leader>bA', ':%bd|e#|bd#<CR>', { desc = '[B]uffer delete [A]ll but this' })
nnoremap('bj', ':bprev<CR>')
nnoremap('bk', ':bnext<CR>')

-- Move block
vnoremap('<Down>', ":m '>+1<CR>gv=gv")
vnoremap('<Up>', ":m '<-2<CR>gv=gv")

-- Replace in file
nnoremap('<Leader>s', ':%s//gI<Left><Left><Left>', { desc = '[S]earch and Replace in file' })
