return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = function(_, opts)
    local parsers = { 'lua', 'vim', 'json', 'toml', 'yaml', 'xml', 'bash' }
    opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, parsers)
    return opts
  end,
  config = function(_, opts)
    require('nvim-treesitter').install(opts.ensure_installed)
  end,
}
