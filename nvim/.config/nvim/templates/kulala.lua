vim.pack.add({
  'https://github.com/mistweaverco/kulala.nvim',
})

require('nvim-treesitter').install({ 'http' })
require('kulala').setup({
  global_keymaps = true,
  global_keymaps_prefix = '<leader>k',
})
require('which-key').add({ '<leader>k', group = 'Kulala' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'http' },
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})
