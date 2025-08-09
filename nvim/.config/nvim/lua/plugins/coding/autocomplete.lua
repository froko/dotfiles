return {
  'Saghen/blink.cmp',
  event = 'InsertEnter',
  opts = {
    fuzzy = { implementation = 'lua' },
    sources = { default = { 'lsp', 'buffer', 'path' } },
  },
}
