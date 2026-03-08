local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf

    local function is_ts_like(ft)
      return ft == 'typescript' or ft == 'typescriptreact' or ft == 'javascript' or ft == 'javascriptreact'
    end

    local function gra()
      local ft = vim.bo[bufnr].filetype

      if is_ts_like(ft) then
        vim.lsp.buf.code_action({
          context = {
            only = { 'quickfix', 'refactor', 'source' },
            diagnostics = vim.diagnostic.get(bufnr),
          },
        })
      else
        vim.lsp.buf.code_action()
      end
    end

    local fzf = require('fzf-lua')

    nnoremap('gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: Go to definition' })
    nnoremap('gra', gra, { buffer = bufnr, desc = 'LSP: Code action' })
    vnoremap('gra', gra, { buffer = bufnr, desc = 'LSP: Code action' })
    nnoremap('gri', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'LSP: Implementation' })
    nnoremap('grn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: Rename' })
    nnoremap('grr', fzf.lsp_references, { buffer = bufnr, desc = 'LSP: References' })
    nnoremap('grt', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP: Go to type definition' })
    nnoremap('K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: Hover' })
  end,
})

local severity = vim.diagnostic.severity
vim.diagnostic.config({
  virtual_lines = true,
  signs = {
    text = {
      [severity.ERROR] = ' ',
      [severity.WARN] = ' ',
      [severity.HINT] = '󰠠 ',
      [severity.INFO] = ' ',
    },
  },
})
