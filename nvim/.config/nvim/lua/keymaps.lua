local nnoremap = require('utils').nnoremap
local inoremap = require('utils').inoremap
local vnoremap = require('utils').vnoremap

-- Core
inoremap('jk', '<Esc>') -- Map 'jk' to <Esc>

-- Navigation
nnoremap('L', '$') -- Go to end of line
nnoremap('H', '^') -- Go to first character of line

-- Buffers
nnoremap('<Tab>', ':bnext<CR>') -- Go to next buffer
nnoremap('<S-Tab>', ':bprevious<CR>') -- Go to previous buffer
nnoremap('bd', ':bd<CR>') -- Close buffer
nnoremap('bD', ':bd!<CR>') -- Close buffer w/o saving

-- Splits
nnoremap('<C-h>', ':wincmd h<CR>') -- Select left split
nnoremap('<C-j>', ':wincmd j<CR>') -- Select split below
nnoremap('<C-k>', ':wincmd k<CR>') -- Select split above
nnoremap('<C-l>', ':wincmd l<CR>') -- Select right split
nnoremap('ss', '<C-w>v') -- Split vertically
nnoremap('sS', '<C-w>n') -- Split horizontally
nnoremap('sd', '<C-w>c') -- Close split

-- Press 'S' for quick find/replace for the word under the cursor
nnoremap('S', ':%s//gI<Left><Left><Left>')

-- Move block
vnoremap('<Down>', ":m '>+1<CR>gv=gv")
vnoremap('<Up>', ":m '<-2<CR>gv=gv")