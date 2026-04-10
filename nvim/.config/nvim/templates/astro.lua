local utils = require('utils')

utils.ensure_installed({ 'astro-language-server' })
utils.enable_treesitter({ 'astro' })

require('conform').formatters_by_ft.astro = { 'prettier' }
require('lint').linters_by_ft.astro = { 'eslint' }

vim.lsp.enable('astro')
