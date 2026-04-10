require('utils').ensure_installed({ 'lua-language-server', 'stylua' })
require('nvim-treesitter').install({ 'lua' })
require('conform').formatters_by_ft.lua = { 'stylua' }

vim.lsp.enable('lua_ls')
