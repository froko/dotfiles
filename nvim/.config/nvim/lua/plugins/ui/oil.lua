local nnoremap = require('utils').nnoremap

return {
  'stevearc/oil.nvim',
  event = 'VeryLazy',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    nnoremap('-', '<CMD>Oil<CR>')

    require('oil').setup({
      default_file_explorer = true,
      delete_to_trash = true,
      use_default_keymaps = false,
      keymaps = {
        ['g?'] = { 'actions.show_help', mode = 'n' },
        ['<CR>'] = 'actions.select',
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['-'] = { 'actions.parent', mode = 'n' },
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == '..' or name == '.git'
        end,
      },
    })
  end,
}
