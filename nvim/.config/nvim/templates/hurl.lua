-- templates/hurl.lua
--
-- Hurl HTTP file runner: execute .hurl files directly from the editor.
-- Provides two keymaps:
--   <leader>hr - run all requests in the file
--   <leader>ht - run requests in test mode (assert-only)

-- ── Plugin declarations ──────────────────────────────────────────────

vim.pack.add({
  'https://github.com/samueljoli/hurl.nvim',
})

require('nvim-treesitter').install({ 'hurl' })
require('hurl').setup()

-- ── Keymaps ──────────────────────────────────────────────────────────

require('which-key').add({ '<leader>h', group = 'Hurl' })
local nnoremap = require('utils').nnoremap

-- Run all requests in the current .hurl file
nnoremap('<leader>hr', function()
  vim.cmd('write')
  local file = vim.fn.shellescape(vim.fn.expand('%'))
  local cmd = 'hurl --no-output ' .. file .. ' 2>&1'
  local output = vim.fn.system(cmd)
  if vim.v.shell_error == 0 then
    vim.notify('Hurl: Requests executed successfully', vim.log.levels.INFO)
  else
    vim.notify('Hurl: Execution failed!\n' .. output, vim.log.levels.ERROR)
  end
end, { desc = 'Run Hurl file' })

-- Run requests in test/assertion mode
nnoremap('<leader>ht', function()
  vim.cmd('write')
  local file = vim.fn.shellescape(vim.fn.expand('%'))
  local cmd = 'hurl --test --no-output ' .. file .. ' 2>&1'
  local output = vim.fn.system(cmd)
  if vim.v.shell_error == 0 then
    vim.notify('Hurl: All tests passed', vim.log.levels.INFO)
  else
    vim.notify('Hurl: Tests failed!\n' .. output, vim.log.levels.ERROR)
  end
end, { desc = 'Test Hurl file' })
