return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'VeryLazy',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'lua', 'vim', 'javascript', 'html', 'css', 'markdown', 'markdown_inline' },
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
  end,
}
