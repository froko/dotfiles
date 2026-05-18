return {
  cmd = function(dispatchers, config)
    local cmd = 'oxlint'
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then
        cmd = local_cmd
      end
    end
    return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers)
  end,
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
  },
  root_markers = { '.oxlintrc.json', '.oxlintrc.jsonc', 'oxlint.config.ts' },
  workspace_required = true,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspOxlintFixAll', function()
      client:exec_cmd({
        title = 'Apply Oxlint automatic fixes',
        command = 'oxc.fixAll',
        arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
      })
    end, { desc = 'Apply Oxlint automatic fixes' })
  end,
}
