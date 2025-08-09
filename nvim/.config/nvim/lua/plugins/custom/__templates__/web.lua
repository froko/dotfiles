vim.lsp.enable('eslint')
vim.lsp.enable('ts-ls')
vim.lsp.enable('astro')
vim.lsp.enable('tailwindcss')

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      local tools = {
        'eslint-lsp',
        'typescript-language-server',
        'astro-language-server',
        'tailwindcss-language-server',
      }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, tools)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      local parsers = { 'javascript', 'typescript', 'astro', 'svelte', 'html', 'css' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, parsers)
      opts.markdown = { enable = true }
      opts.markdown_inline = { enable = true }
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local formatters = {
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        astro = { 'prettier' },
        svelte = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
      }
      opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, formatters)
    end,
  },
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      local linters = {
        javascript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescript = { 'eslint' },
        typescriptreact = { 'eslint' },
        astro = { 'eslint' },
        svelte = { 'eslint' },
      }
      opts.linters_by_ft = vim.tbl_deep_extend('force', opts.linters_by_ft or {}, linters)
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
