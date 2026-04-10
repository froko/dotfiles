require('utils').ensure_installed({ 'angular-language-server' })
require('nvim-treesitter').install({ 'angular' })

vim.lsp.config('angularls', {
  on_attach = function(client)
    client.server_capabilities.referencesProvider = false
    client.server_capabilities.definitionProvider = false
  end,
})
vim.lsp.enable('angularls')
