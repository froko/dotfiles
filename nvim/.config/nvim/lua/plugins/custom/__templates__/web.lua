local web_filetypes = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'html',
  'css',
  'astro',
  'vue',
  'svelte',
}

local function setup_eslint_autofix(bufnr)
  local function eslint_fix()
    vim.lsp.buf.code_action({
      context = { only = { 'source.fixAll.eslint' } },
      apply = true,
    })
  end

  vim.api.nvim_buf_create_user_command(bufnr, 'EslintFixAll', eslint_fix, {
    desc = 'Fix all ESLint errors',
  })

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    desc = 'Auto-fix ESLint on save',
    callback = eslint_fix,
  })
end

vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = web_filetypes,
  settings = {
    validate = 'on',
    packageManager = 'npm',
    useESLintClass = false,
    showStatus = true,
    workingDirectory = { mode = 'location' },
    codeAction = {
      disableRuleComment = { enable = true, location = 'separateLine' },
      showDocumentation = { enable = true },
    },
    codeActionOnSave = { enable = false, mode = 'all' },
  },
  on_attach = function(_, bufnr)
    setup_eslint_autofix(bufnr)
  end,
})

vim.lsp.enable('eslint')
vim.lsp.enable('tailwindcss')

local function set_for_filetypes(filetypes, value)
  local result = {}
  for _, ft in ipairs(filetypes) do
    result[ft] = value
  end
  return result
end

return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      filetypes = web_filetypes,
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        'eslint-lsp',
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft =
        vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, set_for_filetypes(web_filetypes, { 'prettier' }))
    end,
  },
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      opts.linters_by_ft =
        vim.tbl_deep_extend('force', opts.linters_by_ft or {}, set_for_filetypes(web_filetypes, { 'eslint' }))
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {},
  },
}
