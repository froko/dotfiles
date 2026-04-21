require('utils').ensure_installed({ 'cspell-lsp' })

vim.lsp.enable('cspell_ls')

local nnoremap = require('utils').nnoremap
nnoremap('<leader>as', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = 'cspell_ls' })

  if #clients > 0 then
    for _, client in ipairs(clients) do
      client:stop()
    end
    vim.notify('cspell LSP disabled', vim.log.levels.INFO)
  else
    vim.lsp.enable('cspell_ls')
    vim.notify('cspell LSP enabled', vim.log.levels.INFO)
  end
end, { desc = 'Toggle cspell LSP' })
