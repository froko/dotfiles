vim.lsp.enable('angularls')
vim.lsp.config('angularls', {
  on_attach = function(client)
    client.server_capabilities.referencesProvider = false
    client.server_capabilities.definitionProvider = false
  end,
})

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      local tools = { 'angular-language-server' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, tools)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      local parsers = { 'angular' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, parsers)
      return opts
    end,
  },
}
