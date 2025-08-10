local nnoremap = require('utils').nnoremap

local coding_plugins_loaded, blink = pcall(require, 'blink.cmp')

if (coding_plugins_loaded == true) then
  vim.lsp.enable('lua_ls')
  vim.lsp.config('*', { capabilities = blink.get_lsp_capabilities() })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      nnoremap('gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = '[G]oto [D]efinition' })
    end,
  })

  vim.diagnostic.config({ virtual_lines = true })
end
