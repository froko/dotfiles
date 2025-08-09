local nnoremap = require('utils').nnoremap

return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    use_default_keymaps = false,
    keymaps = {
      ['-'] = { 'actions.parent', mode = 'n' },
      ['g?'] = { 'actions.show_help', mode = 'n' },
      ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
      ['<CR>'] = 'actions.select',
      ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
      ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
      ['<C-c>'] = { 'actions.close', mode = 'n' },
    },
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name, _)
        return name == '..' or name == '.git'
      end,
    },
  },
  config = function(_, opts)
    require('oil').setup(opts)
    nnoremap('-', '<CMD>Oil<CR>')
  end,
}
