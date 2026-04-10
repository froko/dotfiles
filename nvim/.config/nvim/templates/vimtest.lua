vim.pack.add({
  'https://github.com/vim-test/vim-test',
})

require('which-key').add({ '<leader>t', group = 'Test' })
local nnoremap = require('utils').nnoremap
nnoremap('<leader>tt', '<cmd>TestNearest<cr>', { desc = 'Test Nearest' })
nnoremap('<leader>tf', '<cmd>TestFile<cr>', { desc = 'Test File' })
nnoremap('<leader>ts', '<cmd>TestSuite<cr>', { desc = 'Test Suite' })
nnoremap('<leader>tl', '<cmd>TestLast<cr>', { desc = 'Test Last' })
nnoremap('<leader>tg', '<cmd>TestVisit<cr>', { desc = 'Test Visit' })

local function get_test_runner()
  local current_file = vim.fn.expand('%:p')
  if
    string.match(current_file, '/e2e/.*%.js$')
    or string.match(current_file, '/e2e/.*%.jsx$')
    or string.match(current_file, '/e2e/.*%.ts$')
    or string.match(current_file, '/e2e/.*%.tsx$')
  then
    return 'playwright'
  else
    return 'jest'
  end
end

vim.g['test#strategy'] = 'neovim_sticky'

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('VimTestRunner', { clear = true }),
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
  callback = function()
    local runner = get_test_runner()
    vim.g['test#javascript#runner'] = runner
  end,
})
