return {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = { 'astro.config.mjs', 'astro.config.js', 'astro.config.ts', 'astro.config.mts' },
  init_options = {
    typescript = {},
  },
  before_init = function(_, config)
    -- Resolve the TypeScript SDK path from the project or Mason
    local root = config.root_dir or vim.fn.getcwd()
    local local_tsdk = root .. '/node_modules/typescript/lib'

    if vim.uv.fs_stat(local_tsdk) then
      config.init_options.typescript.tsdk = local_tsdk
    else
      -- Fall back to Mason's vtsls bundled TypeScript
      local mason_tsdk = vim.fn.expand('$MASON/packages/vtsls/node_modules/typescript/lib')
      if vim.uv.fs_stat(mason_tsdk) then
        config.init_options.typescript.tsdk = mason_tsdk
      end
    end
  end,
}
