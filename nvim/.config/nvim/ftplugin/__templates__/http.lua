vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'http' },
  callback = function()
    vim.treesitter.start()
  end,
})
