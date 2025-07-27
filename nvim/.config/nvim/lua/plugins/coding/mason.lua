return {
  'williamboman/mason.nvim',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  build = ':MasonUpdate',
  config = function()
    require('mason').setup()
    require('mason-tool-installer').setup({
      ensure_installed = {
        'astro-language-server',
        'lua-language-server',
        'typescript-language-server',
        'tailwindcss-language-server',
        'stylua',
        'marksman',
        'prettier',
        'eslint_d',
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 5,
    })
  end,
}
