local utils = require('utils')

utils.ensure_installed({ 'svelte-language-server' })
utils.enable_treesitter({ 'svelte' })

require('conform').formatters_by_ft.svelte = { 'prettier' }
require('lint').linters_by_ft.svelte = { 'eslint' }

vim.lsp.enable('svelte')
