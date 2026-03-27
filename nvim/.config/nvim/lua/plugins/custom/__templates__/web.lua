-- Filetypes for web development
local web_filetypes = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
}

local all_web_filetypes = vim.list_extend(vim.deepcopy(web_filetypes), {
  'html',
  'css',
  'vue',
  'svelte',
})

-- ESLint auto-fix on save
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

-- Configure ESLint LSP
vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = all_web_filetypes,
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

-- Helper to set same config for multiple filetypes
local function set_for_filetypes(filetypes, value)
  local result = {}
  for _, ft in ipairs(filetypes) do
    result[ft] = value
  end
  return result
end

return {
  -- TypeScript language server
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  -- Mason tool installer
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        'eslint-lsp',
      })
    end,
  },

  -- Prettier formatting
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft =
        vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, set_for_filetypes(all_web_filetypes, { 'prettier' }))
    end,
  },

  -- ESLint linting
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      opts.linters_by_ft =
        vim.tbl_deep_extend('force', opts.linters_by_ft or {}, set_for_filetypes(web_filetypes, { 'eslint' }))
    end,
  },
}
