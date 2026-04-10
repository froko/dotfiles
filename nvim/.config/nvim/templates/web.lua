require('utils').ensure_installed({ 'vtsls', 'prettier', 'eslint-lsp', 'tailwindcss-language-server' })

local base_web_filetypes = { 'html', 'css' }
local lintable_web_filetypes = { 'javascript', 'typescript' }
local all_web_filetypes = vim.list_extend(vim.deepcopy(base_web_filetypes), lintable_web_filetypes)

require('utils').enable_treesitter(all_web_filetypes)

local function set_for_filetypes(filetypes, tool, value)
  for _, ft in ipairs(filetypes) do
    tool[ft] = value
  end
end

local format = require('conform').formatters_by_ft
local lint = require('lint').linters_by_ft
set_for_filetypes(all_web_filetypes, format, { 'prettier' })
set_for_filetypes(lintable_web_filetypes, lint, { 'eslint' })

local function eslint_fix()
  local clients = vim.lsp.get_clients({ name = 'eslint', bufnr = 0 })
  if #clients == 0 then
    return
  end
  vim.lsp.buf.code_action({
    context = { only = { 'source.fixAll.eslint' } },
    apply = true,
  })
end

local function setup_eslint_autofix(bufnr)
  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    desc = 'Auto-fix ESLint on save',
    callback = eslint_fix,
  })
end

local function setup_eslint_fix_all_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'LspEslintFixAll', function()
    client:request_sync('workspace/executeCommand', {
      command = 'eslint.applyAllFixes',
      arguments = {
        {
          uri = vim.uri_from_bufnr(bufnr),
          version = vim.lsp.util.buf_versions[bufnr],
        },
      },
    }, nil, bufnr)
  end, {})
end

vim.lsp.config('eslint', {
  settings = {
    codeActionOnSave = { enable = false, mode = 'all' },
  },
  on_attach = function(client, bufnr)
    setup_eslint_autofix(bufnr)
    setup_eslint_fix_all_command(client, bufnr)
  end,
})

vim.lsp.enable({ 'vtsls', 'eslint', 'tailwindcss' })
