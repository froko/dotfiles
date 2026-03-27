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

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('VimTestRunner', { clear = true }),
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
  callback = function()
    local runner = get_test_runner()
    vim.g['test#javascript#runner'] = runner
  end,
})

return {
  'vim-test/vim-test',
  keys = {
    { '<leader>tt', '<cmd>TestNearest<cr>', desc = 'Test Nearest' },
    { '<leader>tf', '<cmd>TestFile<cr>', desc = 'Test File' },
    { '<leader>ts', '<cmd>TestSuite<cr>', desc = 'Test Suite' },
    { '<leader>tl', '<cmd>TestLast<cr>', desc = 'Test Last' },
    { '<leader>tg', '<cmd>TestVisit<cr>', desc = 'Test Visit' },
  },
  config = function()
    vim.g['test#strategy'] = 'neovim_sticky'
  end,
}
