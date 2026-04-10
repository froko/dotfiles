vim.pack.add({
  'https://github.com/folke/flash.nvim',
})

require('utils').nnoremap('s', function()
  require('flash').jump()
end, { desc = 'Flash' })
