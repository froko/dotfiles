vim.pack.add({
  'https://github.com/askfiy/http-client.nvim',
})

require('nvim-treesitter').install({ 'http' })
require('http-client').setup()
require('utils').nnoremap('<leader>hs', ':HttpClient sendRequest<CR>', { desc = 'Send HTTP request' })
