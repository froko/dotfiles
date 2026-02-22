vim.lsp.enable('astro')

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      local tools = { 'astro-language-server' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, tools)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      local parsers = { 'astro' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, parsers)
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local formatters = { astro = { 'prettier' } }
      opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, formatters)
    end,
  },
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      local linters = { astro = { 'eslint' } }
      opts.linters_by_ft = vim.tbl_deep_extend('force', opts.linters_by_ft or {}, linters)
    end,
  },
}
