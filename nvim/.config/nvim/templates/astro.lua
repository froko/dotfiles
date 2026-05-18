require('utils').ensure_installed({ 'astro-language-server' })
require('nvim-treesitter').install({ 'astro' })
require('conform').formatters_by_ft.astro = { 'oxfmt', 'prettier', stop_after_first = true }
require('utils').setup_web_lint_autocmd('*.astro')

vim.lsp.enable('astro')
