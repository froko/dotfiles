local nnoremap = require('utils').nnoremap
local inoremap = require('utils').inoremap
local vnoremap = require('utils').vnoremap

inoremap('jk', '<Esc>') -- Map 'jk' to <Esc>

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

-- Color Column
nnoremap('CC', ':set colorcolumn=0<CR>') -- Disable color column
nnoremap('cc8', ':set colorcolumn=80<CR>') -- Set color column (80)
nnoremap('cc10', ':set colorcolumn=100<CR>') -- Set color column (100)
nnoremap('cc12', ':set colorcolumn=120<CR>') -- Set color column (120)

-- Press 'S' for quick find/replace for the word under the cursor
nnoremap('S', ':%s//gI<Left><Left><Left>')

-- Move block
vnoremap('<Down>', ":m '>+1<CR>gv=gv")
vnoremap('<Up>', ":m '<-2<CR>gv=gv")

-- NeoTree
nnoremap('<Leader>e', ':Neotree filesystem toggle left<CR>')
