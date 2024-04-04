vim.api.nvim_create_autocmd('VimResized', {
  group = vim.api.nvim_create_augroup('WinResize', { clear = true }),
  pattern = '*',
  command = 'wincmd =',
  desc = 'Auto-resize splits on terminal buffer resize.',
})
