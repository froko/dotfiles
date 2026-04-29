vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Automatically resize windows when the terminal size changes',
  pattern = '*',
  command = 'tabdo wincmd =',
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Open help files in a vertical split',
  pattern = 'help',
  callback = function()
    vim.cmd('wincmd L')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close certain filetypes with <q>',
  pattern = { 'qf', 'help', 'man', 'notify' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

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

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Remove trailing whitespace on save',
  pattern = '*',
  command = [[%s/\s\+$//e]],
})
