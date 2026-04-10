vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'ttps://github.com/sindrets/diffview.nvim',
  'https://github.com/neogitorg/neogit',
  'https://github.com/lewis6991/gitsigns.nvim',
})

require('which-key').add({ '<leader>g', group = 'Git' })
require('utils').nnoremap('<leader>gg', ':Neogit<CR>', { desc = 'Open Neogit' })
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, { desc = 'Go to next hunk' })

    map('n', '[h', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, { desc = 'Go to previous hunk' })

    -- Actions
    map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
    map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset hunk' })

    map('v', '<leader>gs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'Stage selected hunk' })

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
    map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
    map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
    map('n', '<leader>gi', gitsigns.preview_hunk_inline, { desc = 'Preview hunk inline' })

    map('n', '<leader>gb', function()
      gitsigns.blame_line({ full = true })
    end, { desc = 'Blame line' })

    map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff this' })

    map('n', '<leader>gD', function()
      gitsigns.diffthis('~')
    end, { desc = 'Diff this against index' })

    map('n', '<leader>gQ', function()
      gitsigns.setqflist('all')
    end, { desc = 'Set quickfix list to all hunks' })
    map('n', '<leader>gq', gitsigns.setqflist, { desc = 'Set quickfix list to hunks' })

    -- Toggles
    map('n', '<leader>ab', gitsigns.toggle_current_line_blame, { desc = 'Toggle current line blame' })
    map('n', '<leader>ww', gitsigns.toggle_word_diff, { desc = 'Toggle word diff' })
  end,
})
