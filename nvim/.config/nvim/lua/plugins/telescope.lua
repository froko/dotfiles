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
    nnoremap('<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    nnoremap('<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    nnoremap('<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    nnoremap('<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
    nnoremap('<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    nnoremap('<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    nnoremap('<leader>fr', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    nnoremap('<leader>fs', builtin.lsp_document_symbols, { desc = '[F]ind [S]ymbols' })
    nnoremap('<leader>fS', builtin.lsp_dynamic_workspace_symbols, { desc = '[F]ind Workspace Symbols' })
    nnoremap('<leader>fn', ':Telescope notify<CR>', { desc = '[F]ind [N]otifications' })
    nnoremap('<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>f.', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = '[F]ind Neovim config files' })
  end,
}
