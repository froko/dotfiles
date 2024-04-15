return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'windwp/nvim-ts-autotag' },
  config = function()
    local treesitter = require 'nvim-treesitter.configs'
    treesitter.setup {
      modules = {},
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      ignore_install = {},
      ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'json',
        'yaml',
        'html',
        'css',
        'javascript',
        'typescript',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-Space>',
          node_incremental = '<C-Space>',
          scope_incremental = false,
          node_decremental = '<BS>',
        },
      },
    }
  end,
}
