-- lua/keymaps.lua
--
-- Global keymaps (mode-agnostic, non-plugin-specific).
-- Plugin-specific keymaps live in their respective config files.

local inoremap = require('utils').inoremap
local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

-- ── Core ─────────────────────────────────────────────────────────────

inoremap('jk', '<Esc>')
nnoremap('<leader>r', ':e!<CR>', { desc = 'Reload file' })
nnoremap('<leader>as', ':setlocal spell!<CR>', { desc = 'Toggle Spellcheck' })
nnoremap('<Esc>', '<CMD>noh<CR>', { desc = 'Clear search highlight' })

-- ── Navigation ───────────────────────────────────────────────────────
-- Keep cursor centered when scrolling half-pages.

nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')

-- ── Buffer management ────────────────────────────────────────────────

-- Delete current buffer (switch to previous first to preserve layout)
nnoremap('<leader>bb', ':bp<bar>sp<bar>bn<bar>bd<CR>', { desc = 'Delete buffer' })

-- Delete all non-terminal buffers
nnoremap('<leader>ba', function()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      local buftype = vim.bo[buf].buftype
      if buftype ~= 'terminal' then
        vim.api.nvim_buf_delete(buf, { force = false })
      end
    end
  end
end, { desc = 'Delete all buffers' })

-- Delete all non-terminal buffers except the current one
nnoremap('<leader>bA', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      local buftype = vim.bo[buf].buftype
      if buftype ~= 'terminal' then
        vim.api.nvim_buf_delete(buf, { force = false })
      end
    end
  end
end, { desc = 'Delete all buffers but this' })

-- ── Visual mode: move selected lines ─────────────────────────────────

vnoremap('<Down>', ":m '>+1<CR>gv=gv")
vnoremap('<Up>', ":m '<-2<CR>gv=gv")

-- ── Search and replace ───────────────────────────────────────────────

nnoremap('<Leader>s', ':%s//gI<Left><Left><Left>', { silent = false, desc = 'Search and Replace in file' })
