return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    opts = function(_, opts)
      local tools = { 'lua-language-server', 'stylua', 'prettier' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, tools)
    end,
    config = function(_, opts)
      require('mason-tool-installer').setup(opts)
    end,
  },
  {
    'williamboman/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },
}
