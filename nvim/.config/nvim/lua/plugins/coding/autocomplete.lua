return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    'folke/lazydev.nvim',
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- Add more snippets like friendly-snippets
      },
      opts = {},
    },
  },
  opts = {
    keymap = {
      preset = 'default',
      ['<C-;>'] = { 'show' },
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
  },
}
