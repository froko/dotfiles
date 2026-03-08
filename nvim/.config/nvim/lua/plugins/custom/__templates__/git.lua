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
        nnoremap('<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
        nnoremap('<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
        vnoremap('<leader>hs', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { buffer = bufnr, desc = 'Stage hunk' })
        vnoremap('<leader>hr', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { buffer = bufnr, desc = 'Reset hunk' })

        nnoremap('<leader>hS', gs.stage_buffer, { buffer = bufnr, desc = 'Stage buffer' })
        nnoremap('<leader>hR', gs.reset_buffer, { buffer = bufnr, desc = 'Reset buffer' })

        nnoremap('<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })

        nnoremap('<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
        nnoremap('<leader>hb', function()
          gs.blame_line({ full = true })
        end, { buffer = bufnr, desc = 'Blame line' })
        nnoremap('<leader>hB', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle line blame' })

        nnoremap('<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Diff this' })
        nnoremap('<leader>hD', function()
          gs.diffthis('~')
        end, { buffer = bufnr, desc = 'Diff this ~' })
      end,
    },
  },
}
