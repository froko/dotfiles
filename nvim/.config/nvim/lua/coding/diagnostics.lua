local severity = vim.diagnostic.severity
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = '●',
    source = 'if_many',
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
    source = true,
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

require('utils').nnoremap('<leader>ad', toggle_diagnostics, { desc = 'Toggle diagnostics' })
