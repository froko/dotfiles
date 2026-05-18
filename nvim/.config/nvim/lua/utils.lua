local M = {}

local function bind(op, outer_opts)
  outer_opts = vim.tbl_extend('force', { noremap = true, silent = true }, outer_opts or {})

  return function(lhs, rhs, opts)
    opts = vim.tbl_extend('force', outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local function ensure_installed(packages)
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
local oxlint_config_files = { '.oxlintrc.json', '.oxlintrc.jsonc', 'oxlint.config.ts' }

--- Returns a list of applicable web linters for the given buffer
--- based on config file presence in the project.
---@param bufnr number
---@return string[]
local function get_web_linters(bufnr)
  local linters = {}
  if vim.fs.root(bufnr, oxlint_config_files) then
    table.insert(linters, 'oxlint')
  end
  if vim.fs.root(bufnr, eslint_config_files) then
    table.insert(linters, 'eslint')
  end
  return linters
end

--- Creates a BufWritePost/BufReadPost autocmd that dynamically
--- selects oxlint/eslint based on project config presence.
---@param pattern string|string[] file pattern(s) to match
local function setup_web_lint_autocmd(pattern)
  vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
    pattern = pattern,
    callback = function(args)
      local linters = get_web_linters(args.buf)
      if #linters > 0 then
        require('lint').try_lint(linters)
      end
    end,
  })
end

M.nnoremap = bind('n')
M.vnoremap = bind('v')
M.xnoremap = bind('x')
M.inoremap = bind('i')
M.tnoremap = bind('t')
M.ensure_installed = ensure_installed
M.get_web_linters = get_web_linters
M.setup_web_lint_autocmd = setup_web_lint_autocmd

return M
