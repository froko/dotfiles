local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

return {
  {
    'NeogitOrg/neogit',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'ibhagwan/fzf-lua',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Navigation
        nnoremap(']h', gs.next_hunk, { buffer = bufnr, desc = 'Next Hunk' })
        nnoremap('[h', gs.prev_hunk, { buffer = bufnr, desc = 'Prev Hunk' })

        -- Actions
        nnoremap('<leader>gs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
        nnoremap('<leader>gr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
        vnoremap('<leader>gs', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { buffer = bufnr, desc = 'Stage hunk' })
        vnoremap('<leader>gr', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { buffer = bufnr, desc = 'Reset hunk' })

        nnoremap('<leader>gS', gs.stage_buffer, { buffer = bufnr, desc = 'Stage buffer' })
        nnoremap('<leader>gR', gs.reset_buffer, { buffer = bufnr, desc = 'Reset buffer' })

        nnoremap('<leader>gu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })

        nnoremap('<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
        nnoremap('<leader>gb', function()
          gs.blame_line({ full = true })
        end, { buffer = bufnr, desc = 'Blame line' })
        nnoremap('<leader>gB', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle line blame' })

        nnoremap('<leader>gd', gs.diffthis, { buffer = bufnr, desc = 'Diff this' })
        nnoremap('<leader>gD', function()
          gs.diffthis('~')
        end, { buffer = bufnr, desc = 'Diff this ~' })
      end,
    },
  },
}
