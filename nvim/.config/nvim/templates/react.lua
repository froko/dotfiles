local utils = require('utils')

utils.enable_treesitter({ 'jsx', 'tsx' })

local format = require('conform').formatters_by_ft
local lint = require('lint').linters_by_ft

format.javascriptreact = { 'prettier' }
format.typescriptreact = { 'prettier' }
lint.javascriptreact = { 'eslint' }
lint.typescriptreact = { 'eslint' }
