-- templates/vimtest.lua
--
-- Test runner integration via vim-test.
-- Auto-detects Jest vs Playwright based on file path: files under
-- an `e2e/` directory use Playwright, everything else uses Jest.

-- ── Plugin declarations ──────────────────────────────────────────────

vim.pack.add({
  'https://github.com/vim-test/vim-test',
})

-- ── Keymaps ──────────────────────────────────────────────────────────

require('which-key').add({ '<leader>t', group = 'Test' })

local nnoremap = require('utils').nnoremap
nnoremap('<leader>tt', '<cmd>TestNearest<cr>', { desc = 'Test Nearest' })
nnoremap('<leader>tf', '<cmd>TestFile<cr>', { desc = 'Test File' })
nnoremap('<leader>ts', '<cmd>TestSuite<cr>', { desc = 'Test Suite' })
nnoremap('<leader>tl', '<cmd>TestLast<cr>', { desc = 'Test Last' })
nnoremap('<leader>tg', '<cmd>TestVisit<cr>', { desc = 'Test Visit' })

-- ── Runner auto-detection ────────────────────────────────────────────

--- Pick the right JS test runner based on file path.
--- Files under `/e2e/` use Playwright; everything else uses Jest.
---@return string  "playwright" or "jest"
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

-- Use a sticky terminal so test output persists
vim.g['test#strategy'] = 'neovim_sticky'

-- Switch the JS runner dynamically when entering a JS/TS buffer
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('VimTestRunner', { clear = true }),
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
  callback = function()
    local runner = get_test_runner()
    vim.g['test#javascript#runner'] = runner
  end,
})
