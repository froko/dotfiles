require('utils').ensure_installed({ 'svelte-language-server' })
require('nvim-treesitter').install({ 'svelte' })
require('conform').formatters_by_ft.svelte = { 'oxfmt', 'prettier', stop_after_first = true }
require('utils').setup_web_lint_autocmd('*.svelte')

vim.lsp.enable('svelte')
