require('nvim-treesitter').install({ 'jsx', 'tsx' })

local format = require('conform').formatters_by_ft

format.javascriptreact = { 'oxfmt', 'prettier', stop_after_first = true }
format.typescriptreact = { 'oxfmt', 'prettier', stop_after_first = true }

require('utils').setup_web_lint_autocmd({ '*.jsx', '*.tsx' })
