-- lsp/tailwindcss.lua
--
-- Tailwind CSS IntelliSense language server.
--
-- Only activates when a `package.json` exists in the project root AND
-- contains "tailwindcss" as a dependency.  This prevents the server
-- from starting in non-Tailwind projects.
--
-- Lint rules catch common mistakes (invalid apply, conflicting classes).

return {
  cmd = { 'tailwindcss-language-server', '--stdio' },

  -- ── Supported filetypes ──────────────────────────────────────────
  filetypes = {
    'astro',
    'astro-markdown',
    'html',
    'htmlangular',
    'markdown',
    'mdx',
    'css',
    'scss',
    'postcss',
    'javascript',
    'javascriptreact',
    'reason',
    'rescript',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
  },

  -- Enable dynamic file-watching registration (needed for config reloads)
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },

  -- ── Tailwind CSS settings ────────────────────────────────────────
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      -- HTML attributes that contain CSS class names
      classAttributes = {
        'class',
        'className',
        'class:list',
        'classList',
        'ngClass',
      },
      -- Map Angular HTML to standard HTML for class completion
      includeLanguages = { htmlangular = 'html' },
    },
  },

  -- Inject editor tab-size into settings before server starts
  before_init = function(_, config)
    config.settings = vim.tbl_deep_extend('keep', config.settings, {
      editor = { tabSize = vim.lsp.util.get_effective_tabstop() },
    })
  end,

  workspace_required = true,

  -- ── Root detection ───────────────────────────────────────────────
  -- Only start when package.json exists AND mentions "tailwindcss".
  root_dir = function(bufnr, on_dir)
    local pkg_root = vim.fs.root(bufnr, { 'package.json' })
    if pkg_root then
      local ok, content = pcall(vim.fn.readfile, pkg_root .. '/package.json')
      if ok and table.concat(content, '\n'):find('"tailwindcss"') then
        on_dir(pkg_root)
      end
    end
  end,
}
