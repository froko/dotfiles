require('utils').ensure_installed({
  'vtsls',
  'prettier',
  'eslint-lsp',
  'tailwindcss-language-server',
  'oxfmt',
  'oxlint',
})

local base_web_filetypes = { 'html', 'css' }
local lintable_web_filetypes = { 'javascript', 'typescript' }
local all_web_filetypes = vim.list_extend(vim.deepcopy(base_web_filetypes), lintable_web_filetypes)

require('nvim-treesitter').install(all_web_filetypes)

local function set_for_filetypes(filetypes, tool, value)
  for _, ft in ipairs(filetypes) do
    tool[ft] = value
  end
end

-- Condition guard: only run oxfmt if a config file exists in the project
local oxfmt_config_files = { '.oxfmtrc.json', '.oxfmtrc.jsonc', 'oxfmt.config.ts' }
require('conform').formatters.oxfmt = {
  condition = function(self, ctx)
    return vim.fs.root(ctx.buf, oxfmt_config_files) ~= nil
  end,
}

local format = require('conform').formatters_by_ft

-- Use oxfmt first (only runs if condition passes), fallback to prettier
set_for_filetypes(all_web_filetypes, format, { 'oxfmt', 'prettier', stop_after_first = true })

-- Dynamically select and run linters for js/ts based on project config
require('utils').setup_web_lint_autocmd({ '*.js', '*.ts' })

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
      arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
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

vim.lsp.enable({ 'vtsls', 'eslint', 'tailwindcss', 'oxlint' })
