return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.stylua.toml', 'stylua.toml', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      codeLens = { enable = true },
      hint = { enable = true, semicolon = 'Disable' },
      diagnostics = { globals = { 'vim', 'require' } },
      telemetry = { enable = false },
    },
  },
}
