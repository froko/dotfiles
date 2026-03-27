return {
  'stevearc/conform.nvim',
  event = 'BufReadPre',
  cmd = { 'ConformInfo' },
  opts = function(_, opts)
    local formatters = { json = { 'prettier' } }
    opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, formatters)
    opts.format_on_save = { timeout_ms = 1000, lsp_format = 'fallback' }
  end,
}
