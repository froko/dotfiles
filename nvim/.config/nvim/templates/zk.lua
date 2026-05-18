-- templates/zk.lua
--
-- Zettelkasten note-taking via zk-nvim.
-- Uses fzf-lua as the note picker. All keymaps under <leader>z.

-- ── Plugin declarations ──────────────────────────────────────────────

vim.pack.add({
  'https://github.com/zk-org/zk-nvim',
})

-- ── Setup ────────────────────────────────────────────────────────────

require('zk').setup({
  picker = 'fzf_lua',
  lsp = {
    config = {
      cmd = { 'zk', 'lsp' },
      name = 'zk',
      on_attach = function(client)
        -- Disable zk's definition provider (we use marksman for that)
        client.server_capabilities.definitionProvider = false
      end,
    },
  },
  auto_attach = { enabled = true, filetypes = { 'markdown' } },
})

-- ── Keymaps ──────────────────────────────────────────────────────────

require('which-key').add({ '<leader>z', group = 'Zk' })

local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

nnoremap('<leader>zb', '<Cmd>ZkBacklinks<CR>', { desc = 'Search Zk Backlinks' })
nnoremap('<leader>zl', '<Cmd>ZkInsertLink<CR>', { desc = 'Add a Zk note as a link' })
nnoremap('<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { desc = 'Create a new Zk note' })
nnoremap('<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { desc = 'Open Zk notes' })
nnoremap('<leader>zt', '<Cmd>ZkTags<CR>', { desc = 'Search Zk tags' })

vnoremap('<leader>zf', ":'<,'>ZkMatch<CR>", { desc = 'Search Zk notes for visual selection' })
vnoremap('<leader>zl', ":'<,'>ZkNewFromTitleSelection<CR>", { desc = 'Create a new linked Zk note' })
