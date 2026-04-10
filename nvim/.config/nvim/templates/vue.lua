local utils = require('utils')

utils.ensure_installed({ 'vue-language-server' })
utils.enable_treesitter({ 'vue' })

require('conform').formatters_by_ft.vue = { 'prettier' }
require('lint').linters_by_ft.vue = { 'eslint' }

-- In hybrid mode, vtsls handles TypeScript in .vue files via @vue/typescript-plugin.
-- Resolve the plugin path from the Mason-installed vue-language-server.
local vue_plugin_path = vim.fn.expand('$MASON/packages/vue-language-server/node_modules/@vue/language-server')

vim.lsp.config('vtsls', {
  -- Override filetypes to include 'vue' for hybrid mode TypeScript support
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

vim.lsp.enable('vue_ls')
