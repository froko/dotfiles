local nnoremap = require('utils').nnoremap

-- install copilot-languae-server with `npm i -g @github/copilot-language-server`

return {
  'github/copilot.vim',
  event = 'InsertEnter',
  config = function()
    nnoremap('<leader>aa', function()
      if vim.g.copilot_enabled == 0 then
        vim.cmd('Copilot enable')
        print('Copilot Enabled')
      else
        vim.cmd('Copilot disable')
        print('Copilot Disabled')
      end
    end, { desc = 'Toggle Copilot' })
  end,
}
