vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/windwp/nvim-autopairs',
})

require('nvim-treesitter').setup({
  highlight = { enable = true },
  indent = { enable = true },
})
require('mason').setup()
require('conform').setup({
  format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
})
require('nvim-autopairs').setup()

require('nvim-treesitter').install({ 'json', 'toml', 'yaml', 'xml' })

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

require('coding/lsp')
require('coding/diagnostics')
require('coding/lua')
require('coding/markdown')
