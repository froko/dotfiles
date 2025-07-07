local nnoremap = require('utils').nnoremap

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require('telescope.builtin')
    nnoremap('<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    nnoremap('<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    nnoremap('<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    nnoremap('<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    nnoremap('<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    nnoremap('<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    nnoremap('<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    nnoremap('<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    nnoremap('<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>sc', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = '[S]earch Neovim [C]onfig files' })

    vim.keymap.set('n', '<leader>sn', ':Telescope notify<CR>', { desc = '[S]earch [N]otifications' })
  end,
}
