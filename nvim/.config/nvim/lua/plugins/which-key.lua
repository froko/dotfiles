return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    spec = {
      { '<leader>b', group = '[B]uffers' },
      { '<leader>f', group = '[F]ind' },
      { '<leader>o', group = '[O]bsidian' },
      { '<leader>w', group = '[W]indows' },
    },
  },
}
