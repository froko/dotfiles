require('utils').ensure_installed({ 'svelte-language-server' })
require('nvim-treesitter').install({ 'svelte' })
require('conform').formatters_by_ft.svelte = { 'prettier' }
require('lint').linters_by_ft.svelte = { 'eslint' }

vim.lsp.enable('svelte')
