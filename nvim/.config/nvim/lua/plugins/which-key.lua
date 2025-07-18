return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    spec = {
      { '<leader>b', group = '[B]uffers' },
      { '<leader>f', group = '[F]ind' },
      { '<leader>n', group = '[N]otifications' },
      { '<leader>o', group = '[O]bsidian' },
      { '<leader>w', group = '[W]indows' },
    },
  },
  config = function(_, opts)
    require('which-key').setup(opts)
  end,
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
