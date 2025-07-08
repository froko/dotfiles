return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = {
      mappings = true,
    },
    spec = {
      { '<leader>n', group = '[N]otifications' },
      { '<leader>o', group = '[O]bsidian' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]indow' },
    },
  },
}
