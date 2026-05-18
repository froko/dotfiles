-- plugin/web.lua
--
-- Web development stack: TypeScript/JavaScript, HTML, CSS.
-- Sets up tooling (LSPs, formatters, linters) and ESLint auto-fix on save.
--
-- Tools installed via Mason:
--   vtsls            - TypeScript/JavaScript language server
--   prettier         - Formatter (fallback)
--   eslint-lsp       - ESLint language server for diagnostics & code actions
--   tailwindcss-ls   - Tailwind CSS IntelliSense
--   oxfmt            - Fast formatter (preferred when config present)
--   oxlint           - Fast linter (used when config present)

-- ── Mason: ensure tools are installed ────────────────────────────────

require('utils').ensure_installed({
  'vtsls',
  'prettier',
  'eslint-lsp',
  'tailwindcss-language-server',
  'oxfmt',
  'oxlint',
})

-- ── Filetypes ────────────────────────────────────────────────────────
-- `base_web_filetypes`     - formatter-only types (html, css)
-- `lintable_web_filetypes` - types that also get linting (js, ts)
-- `all_web_filetypes`      - union of both groups

local base_web_filetypes = { 'html', 'css' }
local lintable_web_filetypes = { 'javascript', 'typescript' }
local all_web_filetypes = vim.list_extend(vim.deepcopy(base_web_filetypes), lintable_web_filetypes)

-- ── Treesitter: install parsers for all web filetypes ────────────────

require('nvim-treesitter').install(all_web_filetypes)

-- ── Formatting (conform.nvim) ────────────────────────────────────────
-- Strategy: try oxfmt first (only runs when a config file is found in
-- the project root), then fall back to prettier. `stop_after_first`
-- ensures only one formatter runs per save.

--- Assign the same formatter config to every filetype in `filetypes`.
---@param filetypes string[]  list of filetype names
---@param tbl table           conform.formatters_by_ft table to populate
---@param value table         formatter spec (e.g. { 'oxfmt', 'prettier', ... })
local function set_for_filetypes(filetypes, tbl, value)
  for _, ft in ipairs(filetypes) do
    tbl[ft] = value
  end
end

-- oxfmt condition guard: only activate when an oxfmt config exists
local oxfmt_config_files = { '.oxfmtrc.json', '.oxfmtrc.jsonc', 'oxfmt.config.ts' }
require('conform').formatters.oxfmt = {
  condition = function(self, ctx)
    return vim.fs.root(ctx.buf, oxfmt_config_files) ~= nil
  end,
}

local formatters_by_ft = require('conform').formatters_by_ft
set_for_filetypes(all_web_filetypes, formatters_by_ft, { 'oxfmt', 'prettier', stop_after_first = true })

-- ── Linting (nvim-lint) ──────────────────────────────────────────────
-- Dynamically selects oxlint / eslint based on which config files
-- exist in the project root. Runs on BufWritePost and BufReadPost.

require('utils').setup_web_lint_autocmd({ '*.js', '*.ts' })

-- ── ESLint integration ───────────────────────────────────────────────

--- Apply ESLint auto-fix via code action for the current buffer.
--- Silently no-ops when no ESLint client is attached.
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

--- Register a BufWritePre autocmd that runs `eslint_fix` before every save.
---@param bufnr number  buffer to attach the autocmd to
local function setup_eslint_autofix(bufnr)
  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    desc = 'Auto-fix ESLint on save',
    callback = eslint_fix,
  })
end

--- Create the `:LspEslintFixAll` buffer-local command.
--- Sends a synchronous workspace/executeCommand request to apply all fixes.
---@param client vim.lsp.Client  the ESLint LSP client
---@param bufnr number           buffer number
local function setup_eslint_fix_all_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'LspEslintFixAll', function()
    client:request_sync('workspace/executeCommand', {
      command = 'eslint.applyAllFixes',
      arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
    }, nil, bufnr)
  end, {})
end

-- Override ESLint LSP config: disable built-in codeActionOnSave (we handle
-- it ourselves via BufWritePre) and wire up autofix + fix-all command.
vim.lsp.config('eslint', {
  settings = {
    codeActionOnSave = { enable = false, mode = 'all' },
  },
  on_attach = function(client, bufnr)
    setup_eslint_autofix(bufnr)
    setup_eslint_fix_all_command(client, bufnr)
  end,
})

-- ── Enable LSP servers ───────────────────────────────────────────────

vim.lsp.enable({ 'vtsls', 'eslint', 'tailwindcss', 'oxlint' })
