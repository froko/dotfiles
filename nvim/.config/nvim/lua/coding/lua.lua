require('utils').ensure_installed({ 'lua-language-server', 'stylua' })
require('utils').enable_treesitter({ 'lua' })
require('conform').formatters_by_ft.lua = { 'stylua' }

vim.lsp.enable('lua_ls')
