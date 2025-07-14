local inoremap = require('utils').inoremap
local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

-- Core
inoremap('jk', '<Esc>') -- Map 'jk' to <Esc>
nnoremap('<leader>e', ':e!<CR>', { desc = 'r[E]load file' })

-- Navigation
nnoremap('L', '$') -- Go to end of line
nnoremap('H', '^') -- Go to first character of line
nnoremap('<C-d>', '<C-d>zz') -- Scroll down and center
nnoremap('<C-u>', '<C-u>zz') -- Scroll up and center
nnoremap('<C-f>', '<C-f>zz') -- Page down and center
nnoremap('<C-b>', '<C-b>zz') -- Page up and center

-- Windows
nnoremap('<leader>ws', ':vsplit<CR>', { desc = '[W]indow [S]plit (vertically)' })
nnoremap('<leader>wh', ':split<CR>', { desc = '[W]indow Split ([H]orizontally)' })
nnoremap('<leader>ww', ':close<CR>', { desc = '[W]indow Close' })

-- Buffers
nnoremap('bb', ':bdelete<CR>')
nnoremap('bj', ':bprev<CR>')
nnoremap('bl', ':bnext<CR>')

-- Move block
vnoremap('<Down>', ":m '>+1<CR>gv=gv")
vnoremap('<Up>', ":m '<-2<CR>gv=gv")
