return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<Leader>fa', '<CMD>FzfLua files<CR>', desc = '[F]ind [A]ll Files' },
    { '<Leader>fc', '<CMD>FzfLua commands<CR>', desc = '[F]ind [C]ommands' },
    { '<Leader>fd', '<CMD>FzfLua diagnostics_document<CR>', desc = '[F]ind [D]iagnostics in Document' },
    { '<Leader>fD', '<CMD>FzfLua diagnostics_workspace<CR>', desc = '[F]ind [D]iagnostics in Workspace' },
    { '<Leader>ff', '<CMD>FzfLua git_files<CR>', desc = '[F]ind Git [F]iles' },
    { '<Leader>fg', '<CMD>FzfLua live_grep<CR>', desc = '[F]ind with [G]rep' },
    { '<Leader>fh', '<CMD>FzfLua help_tags<CR>', desc = '[F]ind [H]elp' },
    { '<Leader>fk', '<CMD>FzfLua keymaps<CR>', desc = '[F]ind [K]eymaps' },
    { '<Leader>fs', '<CMD>FzfLua lsp_document_symbols<CR>', desc = '[F]ind [S]ymbols in Document' },
    { '<Leader>fS', '<CMD>FzfLua lsp_workspace_symbols<CR>', desc = '[F]ind [S]ymbols in Workspace' },
    { '<Space><Space>', '<CMD>FzfLua buffers<CR>', desc = '[F]ind [B]uffers' },
  },
  config = function()
    local fzf_lua = require('fzf-lua')
    local config = fzf_lua.config
    config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
  end,
}
