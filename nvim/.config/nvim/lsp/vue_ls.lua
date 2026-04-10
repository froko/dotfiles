return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'nuxt.config.ts', 'nuxt.config.js', 'vue.config.js', 'vue.config.mjs', '.git' },
  init_options = {
    typescript = {},
    vue = {
      hybridMode = true,
    },
  },
  before_init = function(_, config)
    -- Resolve the TypeScript SDK path from the project or Mason
    local root = config.root_dir or vim.fn.getcwd()
    local local_tsdk = root .. '/node_modules/typescript/lib'

    if vim.uv.fs_stat(local_tsdk) then
      config.init_options.typescript.tsdk = local_tsdk
    else
      local mason_tsdk = vim.fn.expand('$MASON/packages/vtsls/node_modules/typescript/lib')
      if vim.uv.fs_stat(mason_tsdk) then
        config.init_options.typescript.tsdk = mason_tsdk
      end
    end
  end,
}
