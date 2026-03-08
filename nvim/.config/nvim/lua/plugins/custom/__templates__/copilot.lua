local nnoremap = require('utils').nnoremap

-- install copilot-languae-server with `npm i -g @github/copilot-language-server`

return {
  'github/copilot.vim',
  nnoremap('<leader>tp', function()
    vim.g.copilot_enabled = not vim.g.copilot_enabled
  end, { desc = 'Toggle Copilot' }),
}
