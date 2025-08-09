local function fallback_format(bufnr)
  bufnr = bufnr or 0

  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return
  end
  if not vim.bo[bufnr].modifiable then
    return
  end
  if vim.bo[bufnr].buftype ~= '' then
    return
  end
  if vim.bo[bufnr].readonly then
    return
  end
  if vim.bo[bufnr].filetype == '' then
    return
  end
  if vim.bo[bufnr].binary then
    return
  end

  local with_preserved_view = require('core.utils.nvim_utils').with_preserved_view
  local utils = require('core.utils.text_manipulation')

  utils.trim_whitespace(bufnr)
  utils.squeeze_blank_lines(bufnr)

  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients > 0 then
    vim.lsp.buf.format({ bufnr = bufnr, async = false })
  else
    vim.api.nvim_buf_call(bufnr, function()
      with_preserved_view(function()
        vim.cmd('normal! gg=G')
      end)
    end)
  end
end

return {
  'stevearc/conform.nvim',
  event = 'BufReadPre',
  cmd = { 'ConformInfo' },
  opts = function(_, opts)
    local formatters = { lua = { 'stylua' }, json = { 'prettier' } }

    opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, formatters)
    opts.format_on_save = { timeout_ms = 1000, lsp_format = fallback_format }
  end,
  keys = {
    {
      '<leader>bf',
      function()
        require('conform').format({ async = true, timeout_ms = 1500, lsp_format = fallback_format })
      end,
      desc = '[F]ormat [B]uffer',
    },
  },
}
