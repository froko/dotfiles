vim.lsp.enable('rust-analyzer')

return {
  -- Better way to install rust-analyzer and rustfmt:
  -- rustup component add rust-analyzer rustfmt

  -- {
  --   'WhoIsSethDaniel/mason-tool-installer.nvim',
  --   opts = function(_, opts)
  --     local tools = { 'rust-analyzer' }
  --     opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, tools)
  --   end,
  -- },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      local parsers = { 'rust' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, parsers)
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local formatters = { rust = { 'rustfmt' } }
      opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, formatters)
    end,
  },
}
