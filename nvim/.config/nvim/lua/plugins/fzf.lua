return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<Leader>fd', '<CMD>FzfLua diagnostics_document<CR>', desc = 'Find diagnostics in document' },
    { '<Leader>fD', '<CMD>FzfLua diagnostics_workspace<CR>', desc = 'Find diagnostics in workspace' },
    { '<Leader>ff', '<CMD>FzfLua files<CR>', desc = 'Find files' },
    { '<Leader>fg', '<CMD>FzfLua grep_curbuf<CR>', desc = 'Find text in document' },
    { '<Leader>fG', '<CMD>FzfLua live_grep<CR>', desc = 'Find text in workspace' },
    { '<Leader>fh', '<CMD>FzfLua help_tags<CR>', desc = 'Find help' },
    { '<Leader>fs', '<CMD>FzfLua lsp_document_symbols<CR>', desc = 'Find symbols in document' },
    { '<Leader>fS', '<CMD>FzfLua lsp_workspace_symbols<CR>', desc = 'Find symbols in workspace' },
    { '<Space><Space>', '<CMD>FzfLua buffers<CR>', desc = 'Find buffers' },
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
