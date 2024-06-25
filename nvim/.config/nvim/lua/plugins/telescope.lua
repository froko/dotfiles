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

      telescope.setup {
        defaults = {
          path_display = { 'smart' },
          file_ignore_patterns = { 'node_modules/', '.git/' },
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

      local builtin = require 'telescope.builtin'
      nnoremap('<Leader>ff', function()
        builtin.find_files { hidden = true }
      end, { desc = 'Files' })

      nnoremap('<Leader>fg', builtin.live_grep, { desc = 'Live grep' })
      nnoremap('<Leader>fw', builtin.grep_string, { desc = 'Grep word' })
      nnoremap('<Leader>fh', builtin.help_tags, { desc = 'Help tags' })
      nnoremap('<Leader><Leader>', builtin.buffers, { desc = 'Buffers' })
      nnoremap('<Leader>fr', builtin.oldfiles, { desc = 'Recent files' })
      nnoremap('<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Todos' })

      nnoremap('<Leader>f.', function()
        builtin.find_files { cwd = '~/dotfiles', hidden = true }
      end, { desc = 'Dotfiles' })
    end,
  },
}
