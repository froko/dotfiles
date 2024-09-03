-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local inoremap = require("utils").inoremap
local nnoremap = require("utils").nnoremap
local vnoremap = require("utils").vnoremap

-- Core
inoremap("jk", "<Esc>") -- Map 'jk' to <Esc>
nnoremap("-", "<CMD>Oil<CR>", { desc = " Open parent directory" })

-- Navigation
nnoremap("L", "$") -- Go to end of line
nnoremap("H", "^") -- Go to first character of line

-- Move block
vnoremap("<Down>", ":m '>+1<CR>gv=gv")
vnoremap("<Up>", ":m '<-2<CR>gv=gv")
