require('utils').ensure_installed({ 'astro-language-server' })
require('nvim-treesitter').install({ 'astro' })
require('conform').formatters_by_ft.astro = { 'prettier' }
require('lint').linters_by_ft.astro = { 'eslint' }

vim.lsp.enable('astro')
