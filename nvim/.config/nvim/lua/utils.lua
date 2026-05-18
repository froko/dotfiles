-- lua/utils.lua
--
-- Shared utility functions used across the Neovim config.
-- Provides:
--   - Keymap helpers  (nnoremap, vnoremap, etc.)
--   - Mason package installer
--   - Web linter detection (eslint / oxlint based on project config)

local M = {}

-- ── Keymap helpers ───────────────────────────────────────────────────
-- `bind(mode)` returns a function that sets a keymap with sensible
-- defaults (noremap + silent).  The returned function accepts:
--   lhs  - key sequence
--   rhs  - command / callback
--   opts - optional overrides (e.g. { buffer = 0, desc = "..." })

---@param mode string|string[]  vim mode(s) for the mapping
---@param outer_opts? table     default options merged into every call
---@return fun(lhs: string, rhs: string|function, opts?: table)
local function bind(mode, outer_opts)
  outer_opts = vim.tbl_extend('force', { noremap = true, silent = true }, outer_opts or {})

  return function(lhs, rhs, opts)
    opts = vim.tbl_extend('force', outer_opts, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

M.nnoremap = bind('n')
M.vnoremap = bind('v')
M.xnoremap = bind('x')
M.inoremap = bind('i')
M.tnoremap = bind('t')

-- ── Mason: ensure packages are installed ─────────────────────────────

--- Refresh the Mason registry and install any missing packages.
--- Safe to call multiple times; already-installed packages are skipped.
---@param packages string[]  Mason package names (e.g. { 'prettier', 'eslint-lsp' })
function M.ensure_installed(packages)
  local registry = require('mason-registry')
  registry.refresh(function()
    for _, pkg_name in ipairs(packages) do
      local pkg = registry.get_package(pkg_name)
      if not pkg:is_installed() then
        pkg:install()
      end
    end
  end)
end

-- ── Web linter detection ─────────────────────────────────────────────
-- Determines which linters (oxlint, eslint) apply to a buffer by
-- checking whether their config files exist in the project root.

--- All known ESLint config file names (legacy .eslintrc.* + flat config).
local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}

--- All known oxlint config file names.
local oxlint_config_files = { '.oxlintrc.json', '.oxlintrc.jsonc', 'oxlint.config.ts' }

--- Detect which web linters should run for a given buffer.
--- Walks up the directory tree looking for config files of each tool.
---@param bufnr number  buffer number to check
---@return string[]     list of linter names (e.g. { 'oxlint', 'eslint' })
function M.get_web_linters(bufnr)
  local linters = {}
  if vim.fs.root(bufnr, oxlint_config_files) then
    table.insert(linters, 'oxlint')
  end
  if vim.fs.root(bufnr, eslint_config_files) then
    table.insert(linters, 'eslint')
  end
  return linters
end

--- Create autocmds that dynamically lint JS/TS files on read and save.
--- Uses `get_web_linters` to pick the right tool(s) per project.
---@param pattern string|string[]  file glob(s) to match (e.g. { '*.js', '*.ts' })
function M.setup_web_lint_autocmd(pattern)
  vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
    pattern = pattern,
    callback = function(args)
      local linters = M.get_web_linters(args.buf)
      if #linters > 0 then
        require('lint').try_lint(linters)
      end
    end,
  })
end

return M
