local nnoremap = require('utils').nnoremap

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local nvimtree = require 'nvim-tree'
    nvimtree.setup {
      view = { width = 45, relativenumber = true },
      renderer = {
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = '',
              arrow_open = '',
            },
          },
        },
      },
      filters = {
        custom = { '.DS_Store' },
      },
      git = { ignore = false },
    }

    -- set keymaps
    nnoremap(
      '<leader>ee',
      ':NvimTreeToggle<CR>',
      { desc = 'Toggle file explorer' }
    )
    nnoremap(
      '<leader>ef',
      ':NvimTreeFindFileToggle<CR>',
      { desc = 'Toggle file explorer on current file' }
    )
    nnoremap(
      '<leader>ec',
      ':NvimTreeCollapse<CR>',
      { desc = 'Collapse file explorer' }
    )
  end,
}
