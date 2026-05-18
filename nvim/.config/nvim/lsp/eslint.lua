-- lsp/eslint.lua
--
-- ESLint language-server configuration (vscode-eslint-language-server).
--
-- Supports JavaScript, TypeScript, and framework-specific filetypes
-- (Vue, Svelte, Astro, Angular).  Root detection uses lock files to
-- find the project root.  Custom handlers deal with ESLint-specific
-- LSP notifications (probe failures, missing library, doc opening).

return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },

  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
    'htmlangular',
  },

  workspace_required = true,

  -- ── Root detection ───────────────────────────────────────────────
  -- Prefer lock files (closest monorepo/package root), fall back to .git,
  -- then to cwd as a last resort.
  root_dir = function(bufnr, on_dir)
    local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
    root_markers = vim.list_extend(root_markers, { '.git' })

    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

    on_dir(project_root)
  end,

  -- ── ESLint settings ──────────────────────────────────────────────
  settings = {
    validate = 'on',
    ---@diagnostic disable-next-line: assign-type-mismatch
    packageManager = nil, -- auto-detect
    useESLintClass = false,
    experimental = {},
    codeActionOnSave = {
      enable = false, -- handled by templates/web.lua BufWritePre autocmd
      mode = 'all',
    },
    format = true,
    quiet = false,
    onIgnoredFiles = 'off',
    rulesCustomizations = {},
    run = 'onType',
    problems = {
      shortenToSingleLine = false,
    },
    -- nodePath: directory where eslint resolves node_modules (relative to root)
    nodePath = '',
    -- workingDirectory: use workspace folder or file location as cwd
    workingDirectory = { mode = 'auto' },
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = 'separateLine',
      },
      showDocumentation = {
        enable = true,
      },
    },
  },

  -- ── Lifecycle hooks ──────────────────────────────────────────────

  -- Inject `workspaceFolder` into settings so ESLint knows the project name
  before_init = function(_, config)
    local root_dir = config.root_dir
    if root_dir then
      config.settings = config.settings or {}
      config.settings.workspaceFolder = {
        uri = root_dir,
        name = vim.fn.fnamemodify(root_dir, ':t'),
      }
    end
  end,

  -- ── Custom LSP handlers ──────────────────────────────────────────
  -- ESLint uses non-standard request types for user interaction.

  handlers = {
    -- Open ESLint rule documentation in the browser
    ['eslint/openDoc'] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,

    -- Auto-approve ESLint execution (return code 4 = approved)
    ['eslint/confirmESLintExecution'] = function(_, result)
      if not result then
        return
      end
      return 4
    end,

    -- Warn when ESLint fails to probe the project
    ['eslint/probeFailed'] = function()
      vim.notify('[lsp] ESLint probe failed.', vim.log.levels.WARN)
      return {}
    end,

    -- Warn when ESLint library cannot be found
    ['eslint/noLibrary'] = function()
      vim.notify('[lsp] Unable to find ESLint library.', vim.log.levels.WARN)
      return {}
    end,
  },
}
