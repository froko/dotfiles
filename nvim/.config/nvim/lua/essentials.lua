vim.pack.add({
  'https://github.com/christoomey/vim-tmux-navigator',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/catppuccin/nvim.git',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/folke/which-key.nvim',
})

require('nvim-web-devicons').setup()
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

require('lualine').setup({
  options = {
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
})

require('oil').setup({
  default_file_explorer = true,
  delete_to_trash = true,
  use_default_keymaps = false,
  keymaps = {
    ['-'] = { 'actions.parent', mode = 'n' },
    ['g?'] = { 'actions.show_help', mode = 'n' },
    ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
    ['<CR>'] = 'actions.select',
    ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<C-c>'] = { 'actions.close', mode = 'n' },
  },
  view_options = {
    show_hidden = true,
    natural_order = true,
    is_always_hidden = function(name, _)
      return name == '..' or name == '.git'
    end,
  },
})

local nnoremap = require('utils').nnoremap
nnoremap('-', '<CMD>Oil<CR>', { desc = 'Open file explorer' })

local fzf_lua = require('fzf-lua')
fzf_lua.config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept' -- send selection to quick-fix list
fzf_lua.setup()
fzf_lua.register_ui_select()

nnoremap('<Leader>fd', '<CMD>FzfLua diagnostics_document<CR>', { desc = 'Find diagnostics in document' })
nnoremap('<Leader>fD', '<CMD>FzfLua diagnostics_workspace<CR>', { desc = 'Find diagnostics in workspace' })
nnoremap('<Leader>fg', '<CMD>FzfLua grep_curbuf<CR>', { desc = 'Find text in document' })
nnoremap('<Leader>fG', '<CMD>FzfLua live_grep<CR>', { desc = 'Find text in workspace' })
nnoremap('<Leader>fh', '<CMD>FzfLua help_tags<CR>', { desc = 'Find help' })
nnoremap('<Leader>ff', '<CMD>FzfLua files<CR>', { desc = 'Find files' })
nnoremap('<Leader>fs', '<CMD>FzfLua lsp_document_symbols<CR>', { desc = 'Find symbols in document' })
nnoremap('<Leader>fS', '<CMD>FzfLua lsp_workspace_symbols<CR>', { desc = 'Find symbols in workspace' })
nnoremap('<Space><Space>', '<CMD>FzfLua buffers<CR>', { desc = 'Find buffers' })

require('which-key').setup({
  preset = 'helix',
  spec = {
    { '<leader>a', group = 'Toggle' },
    { '<leader>b', group = 'Buffers' },
    { '<leader>f', group = 'Find' },
  },
})
