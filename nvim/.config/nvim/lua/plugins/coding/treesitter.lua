return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = function(_, opts)
    local parsers = { 'lua', 'vim', 'json', 'toml', 'yaml', 'xml', 'bash' }
    opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, parsers)
  end,
  config = function(_, opts)
    local common_options = {
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          scope_incremental = false,
          node_incremental = '<CR>',
          node_decremental = '<BS>',
        },
      },
    }

    require('nvim-treesitter.configs').setup(vim.tbl_deep_extend('force', common_options, opts))
  end,
}
