return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  build = ':TSUpdate',
  event = 'VeryLazy',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'lua',
        'vim',
        'javascript',
        'typescript',
        'html',
        'css',
        'astro',
        'json',
        'markdown',
        'markdown_inline',
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<Leader>vv',
          scope_incremental = '<Leader>vs',
          node_incremental = '.',
          node_decremental = ',',
        },
      },
      markdown = {
        enable = true,
      },
    })
    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    })
  end,
}
