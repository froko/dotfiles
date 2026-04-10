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

local function enable_treesitter(filetypes)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function(args)
      vim.treesitter.start(args.buf)
    end,
  })
end

M.nnoremap = bind('n')
M.vnoremap = bind('v')
M.xnoremap = bind('x')
M.inoremap = bind('i')
M.tnoremap = bind('t')
M.ensure_installed = ensure_installed
M.enable_treesitter = enable_treesitter

return M
