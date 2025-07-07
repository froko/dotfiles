return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
    },
    spec = {
      { '<leader>n', group = '[N]otifications' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]indow' },
    },
  },
}
