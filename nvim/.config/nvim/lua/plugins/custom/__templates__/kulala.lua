return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      local parsers = { 'http' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, parsers)
      return opts
    end,
  },
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = '<leader>R',
    },
  },
}
