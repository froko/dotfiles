return {
  'Saghen/blink.cmp',
  event = 'InsertEnter',
  opts = {
    fuzzy = { implementation = 'lua' },
    sources = { default = { 'lsp', 'buffer', 'path' } },
    keymap = {
      preset = 'default',
      ['<C-x><C-o>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
    },
  },
}
