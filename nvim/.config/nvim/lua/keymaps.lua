local inoremap = require('utils').inoremap
local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

-- Core
inoremap('jk', '<Esc>')
nnoremap('<leader>r', ':e!<CR>', { desc = 'Reload file' })
nnoremap('<leader>as', ':setlocal spell!<CR>', { desc = 'Toggle Spellcheck' })
nnoremap('<Esc>', '<CMD>noh<CR>', { desc = 'Clear search highlight' })

-- Navigation
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')

-- Buffers
nnoremap('<leader>bb', ':bp<bar>sp<bar>bn<bar>bd<CR>', { desc = 'Delete buffer' })
nnoremap('<leader>ba', ':%bd<CR>', { desc = 'Delete all buffers' })
nnoremap('<leader>bA', ':%bd|e#|bd#<CR>', { desc = 'Delete all buffers but this' })

-- Move block
vnoremap('<Down>', ":m '>+1<CR>gv=gv")
vnoremap('<Up>', ":m '<-2<CR>gv=gv")

-- Replace in file
nnoremap('<Leader>s', ':%s//gI<Left><Left><Left>', { silent = false, desc = 'Search and Replace in file' })
