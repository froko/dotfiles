local nnoremap = require('utils').nnoremap

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    workspaces = {
      { name = '2ndBrain', path = os.getenv('OBSIDIANDIR') or '~/Work/2ndBrain' },
    },
    ui = { enable = false },
    completion = { nvim_cmp = false, blink = true },
    notes_subdir = '0-Inbox',
    new_notes_location = 'notes_subdir',
    templates = { folder = '__Templates' },
  },
  config = function(_, opts)
    local obsidian = require('obsidian').setup(opts)

    nnoremap('<Leader>ob', '<cmd>ObsidianBacklinks<CR>', { desc = 'Obsidian: Backlinks' })
    nnoremap('<Leader>on', '<cmd>ObsidianTemplate Inbox<CR> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>")', { desc = 'Obsidian: New Note' })
    nnoremap('<leader>of', ':s/-/ /g<cr>', { desc = 'Obsidian: Format' })
    nnoremap('<Leader>ot', '<cmd>ObsidianTags<CR>', { desc = 'Obsidian: Tags' })
    nnoremap('<CR>', function()
      obsidian.util.smart_action()
    end, { buffer = true, expr = true })
  end,
}
