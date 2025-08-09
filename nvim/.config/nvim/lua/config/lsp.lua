local nnoremap = require('utils').nnoremap

vim.lsp.enable('lua_ls')
vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    nnoremap('gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = '[G]oto [D]efinition' })
  end,
})

vim.diagnostic.config({ virtual_lines = true })
