local inoremap = require('utils').inoremap
local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

-- Core
inoremap('jk', '<Esc>') -- Map 'jk' to <Esc>

-- Navigation
nnoremap('L', '$') -- Go to end of line
nnoremap('H', '^') -- Go to first character of line

-- Buffers
nnoremap('bj', ':bn<CR>') -- Next buffer
nnoremap('bk', ':bp<CR>') -- Previous buffer
nnoremap('bd', ':bd<CR>') -- Close buffer
nnoremap('bD', ':bd!<CR>') -- Close buffer w/o saving

nnoremap('<leader>mh', ':%s//gI<Left><Left><Left>', { desc = 'Find/Replace' })

-- Move block
vnoremap('<Down>', ":m '>+1<CR>gv=gv")
vnoremap('<Up>', ":m '<-2<CR>gv=gv")
