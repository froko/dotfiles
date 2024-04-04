return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local treesitter = require 'nvim-treesitter.configs'
    treesitter.setup {
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { 'lua', 'vim' },
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
