return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<Leader>fd', '<CMD>FzfLua diagnostics_document<CR>', desc = 'Find Diagnostics' },
    { '<Leader>ff', '<CMD>FzfLua files<CR>', desc = 'Find Files' },
    { '<Leader>fg', '<CMD>FzfLua live_grep<CR>', desc = 'Find with Grep' },
    { '<Leader>fh', '<CMD>FzfLua help_tags<CR>', desc = 'Find Help' },
    { '<Leader>fs', '<CMD>FzfLua treesitter<CR>', desc = 'Find Symbols' },
    { '<Space><Space>', '<CMD>FzfLua buffers<CR>', desc = 'Find Buffers' },
  },
  config = function()
    local fzf_lua = require('fzf-lua')
    local config = fzf_lua.config
    config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'

    fzf_lua.setup({
      files = {
        fd_opts = [[--type f --hidden --exclude .git --exclude node_modules --exclude .obsidian]],
      },
      grep = {
        rg_opts = [[--column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git/*" --glob "!node_modules/*" --glob "!.obsidian/*"]],
      },
    })
  end,
}
