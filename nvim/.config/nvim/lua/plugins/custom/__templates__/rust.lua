vim.lsp.enable('rust-analyzer')

return {
  'stevearc/conform.nvim',
  opts = function(_, opts)
    local formatters = { rust = { 'rustfmt' } }
    opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, formatters)
  end,
}
