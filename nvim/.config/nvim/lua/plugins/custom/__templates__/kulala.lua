-- Enable treesitter for HTTP
-- Note: You need to manually install the parser with :TSInstall http
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'http' },
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})

return {
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = '<leader>R',
    },
  },
}
