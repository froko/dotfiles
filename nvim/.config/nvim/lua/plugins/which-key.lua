return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    spec = {
      { '<leader>a', group = 'Test' },
      { '<leader>b', group = 'Buffers' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>z', group = 'Zk' },
    },
  },
}
