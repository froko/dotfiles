return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    spec = {
      { '<leader>a', group = 'Toggle' },
      { '<leader>b', group = 'Buffers' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>t', group = 'Test' },
      { '<leader>z', group = 'Zk' },
    },
  },
}
