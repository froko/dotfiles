vim.pack.add({
  'https://github.com/github/copilot.vim',
})

require('utils').nnoremap('<leader>aa', function()
  if vim.g.copilot_enabled == 0 then
    vim.cmd('Copilot enable')
    print('Copilot Enabled')
  else
    vim.cmd('Copilot disable')
    print('Copilot Disabled')
  end
end, { desc = 'Toggle Copilot' })
