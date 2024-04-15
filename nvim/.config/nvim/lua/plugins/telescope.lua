local nnoremap = require('utils').nnoremap

return {
  {
    'nvim-telescope/telescope-ui-select.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-tree/nvim-web-devicons',
      'folke/todo-comments.nvim',
    },
    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'
      local themes = require 'telescope.themes'

      telescope.setup {
        extensions = {
          ['ui-select'] = { themes.get_dropdown {} },
        },
        defaults = {
          path_display = { 'smart' },
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      }

      telescope.load_extension 'fzf'
      telescope.load_extension 'ui-select'

      local builtin = require 'telescope.builtin'
      nnoremap('<Leader>ff', builtin.find_files, { desc = 'Files' })
      nnoremap('<Leader>fg', builtin.live_grep, { desc = 'Live grep' })
      nnoremap('<Leader>fw', builtin.grep_string, { desc = 'Grep word' })
      nnoremap('<Leader>fh', builtin.help_tags, { desc = 'Help tags' })
      nnoremap('<Leader>fb', builtin.buffers, { desc = 'Buffers' })
      nnoremap('<Leader><Leader>', builtin.buffers, { desc = 'Buffers' })
      nnoremap('<Leader>fr', builtin.oldfiles, { desc = 'Recent files' })
      nnoremap('<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Todos' })

      nnoremap('<Leader>fc', function()
        builtin.commands(themes.get_dropdown {
          previewer = false,
        })
      end, { desc = 'Commands' })

      nnoremap('<Leader>f.', function()
        builtin.find_files { cwd = '~/dotfiles', hidden = true }
      end, { desc = 'Dotfiles' })
    end,
  },
}
