return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<Leader>fd', '<CMD>FzfLua diagnostics_document<CR>', desc = '[F]ind [D]iagnostics' },
    { '<Leader>ff', '<CMD>FzfLua files<CR>', desc = '[F]ind [F]iles' },
    { '<Leader>fg', '<CMD>FzfLua live_grep<CR>', desc = '[F]ind with [G]rep' },
    { '<Leader>fh', '<CMD>FzfLua help_tags<CR>', desc = '[F]ind [H]elp' },
    { '<Leader>fs', '<CMD>FzfLua treesitter<CR>', desc = '[F]ind [S]ymbols' },
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
