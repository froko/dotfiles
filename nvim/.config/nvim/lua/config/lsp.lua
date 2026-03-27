local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf
    local fzf = require('fzf-lua')

    nnoremap('gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: Go to definition' })
    nnoremap('gra', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: Code action' })
    vnoremap('gra', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: Code action' })
    nnoremap('gri', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'LSP: Implementation' })
    nnoremap('grn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: Rename' })
    nnoremap('grr', fzf.lsp_references, { buffer = bufnr, desc = 'LSP: References' })
    nnoremap('grt', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP: Go to type definition' })
    nnoremap('K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: Hover' })
  end,
})

local severity = vim.diagnostic.severity
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = '●',
    source = 'if_many', -- Show source if multiple sources
  },
  signs = {
    text = {
      [severity.ERROR] = ' ',
      [severity.WARN] = ' ',
      [severity.HINT] = '󰠠 ',
      [severity.INFO] = ' ',
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

local toggle_diagnostics = function()
  local bufnr = 0
  if vim.diagnostic.is_enabled({ bufnr = bufnr }) then
    vim.diagnostic.enable(false, { bufnr = bufnr })
    print('Buffer Diagnostics Off')
  else
    vim.diagnostic.enable(true, { bufnr = bufnr })
    print('Buffer Diagnostics On')
  end
end

nnoremap('<leader>ad', toggle_diagnostics, { desc = 'Toggle diagnostics' })
