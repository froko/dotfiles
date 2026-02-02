return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      transparent_background = true,
      float = { transparent = true, solid = true },
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.subtext0 },
        }
      end,
    })
    vim.cmd.colorscheme('catppuccin-macchiato')
  end,
}
