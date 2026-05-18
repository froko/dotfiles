-- lua/coding/init.lua
--
-- Core coding infrastructure: Treesitter, Mason, formatting, linting,
-- and auto-pairs. Language-specific modules are loaded at the bottom.

-- ── Plugin declarations ──────────────────────────────────────────────

vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter', -- syntax highlighting & text objects
  'https://github.com/mason-org/mason.nvim', -- portable tool installer
  'https://github.com/stevearc/conform.nvim', -- formatter orchestration
  'https://github.com/mfussenegger/nvim-lint', -- async linter integration
  'https://github.com/windwp/nvim-autopairs', -- auto-close brackets/quotes
})

-- ── Plugin setup ─────────────────────────────────────────────────────

require('nvim-treesitter').setup({
  highlight = { enable = true },
  indent = { enable = true },
})

require('mason').setup()

require('conform').setup({
  format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
})

require('nvim-autopairs').setup()

-- ── Data format parsers ──────────────────────────────────────────────

require('nvim-treesitter').install({ 'json', 'toml', 'yaml', 'xml' })

-- ── Lint on read/save ────────────────────────────────────────────────
-- Runs any linters configured via `lint.linters_by_ft` for the buffer.

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

-- ── Language modules ─────────────────────────────────────────────────

require('coding/lsp')
require('coding/diagnostics')
require('coding/lua')
require('coding/markdown')
