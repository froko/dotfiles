vim.lsp.enable('lua_ls')

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      local tools = { 'lua-language-server', 'stylua' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, tools)
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local formatters = { lua = { 'stylua' } }
      opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, formatters)
    end,
  },
}
