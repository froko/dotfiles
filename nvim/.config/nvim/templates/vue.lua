-- templates/vue.lua
--
-- Vue 3 support: LSP (vue_ls + vtsls hybrid mode), formatting, linting.
--
-- Hybrid mode: vtsls handles TypeScript inside .vue files via
-- @vue/typescript-plugin, so only a single TS language server runs.

-- ── Mason: ensure Vue language server is installed ───────────────────

require('utils').ensure_installed({ 'vue-language-server' })

-- ── Treesitter & formatting/linting ──────────────────────────────────

require('nvim-treesitter').install({ 'vue' })
require('conform').formatters_by_ft.vue = { 'oxfmt', 'prettier', stop_after_first = true }
require('utils').setup_web_lint_autocmd('*.vue')

-- ── vtsls: extend filetypes to include Vue (hybrid mode) ─────────────
-- Resolve @vue/typescript-plugin from the Mason-installed vue-language-server.

local vue_plugin_path = vim.fn.expand('$MASON/packages/vue-language-server/node_modules/@vue/language-server')

vim.lsp.config('vtsls', {
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_plugin_path,
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
})

-- ── Enable Vue language server ───────────────────────────────────────

vim.lsp.enable('vue_ls')
