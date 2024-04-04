return {
  {
    'nvim-telescope/telescope-ui-select.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<Leader>sf', builtin.find_files)
      vim.keymap.set('n', '<Leader>sg', builtin.live_grep)
      vim.keymap.set('n', '<Leader>sh', builtin.help_tags)
      vim.keymap.set('n', '<Leader><Leader>', builtin.buffers)
      vim.keymap.set('n', '<Leader>sc', function()
        builtin.commands(require('telescope.themes').get_dropdown {
          previewer = false,
        })
      end)
      vim.keymap.set('n', '<Leader>s.', function()
        builtin.find_files { cwd = '~/dotfiles', hidden = true }
      end)

      require('telescope').load_extension 'ui-select'
    end,
  },
}
