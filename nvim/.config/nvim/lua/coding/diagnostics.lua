-- lua/coding/diagnostics.lua
--
-- Diagnostic display configuration and per-buffer toggle.

-- ── Diagnostic appearance ────────────────────────────────────────────

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = '●',
    source = 'if_many', -- show source only when multiple diagnostics exist
  },
  signs = {
    text = {
      [severity.ERROR] = ' ',
      [severity.WARN] = ' ',
      [severity.HINT] = '󰠠 ',
      [severity.INFO] = ' ',
    },
  },
  underline = true,
  update_in_insert = false, -- avoid flickering while typing
  severity_sort = true, -- errors shown before warnings
  float = {
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
})

-- ── Toggle diagnostics per buffer ────────────────────────────────────

local function toggle_diagnostics()
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
