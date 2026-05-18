-- lua/autocmd.lua
--
-- Global autocommands (non-plugin-specific).

-- ── Visual feedback ──────────────────────────────────────────────────

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ── Window management ────────────────────────────────────────────────

-- Rebalance splits when the terminal is resized
vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Automatically resize windows when the terminal size changes',
  pattern = '*',
  command = 'tabdo wincmd =',
})

-- Open help pages in a vertical split instead of horizontal
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Open help files in a vertical split',
  pattern = 'help',
  callback = function()
    vim.cmd('wincmd L')
  end,
})

-- ── Quick-close filetypes ────────────────────────────────────────────

-- Allow closing transient windows (qf, help, man, notify) with `q`
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close certain filetypes with <q>',
  pattern = { 'qf', 'help', 'man', 'notify' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- ── Cursor position restoration ──────────────────────────────────────

-- Jump to the last known cursor position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Jump to the last known cursor position on opening a file',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
