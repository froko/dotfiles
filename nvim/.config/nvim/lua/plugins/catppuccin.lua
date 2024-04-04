return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      transparent_background = true,
      integrations = {
        mason = true,
        neotree = true,
        telescope = true,
      },
    }

    vim.cmd [[colorscheme catppuccin]]
  end,
}
