vim.pack.add({
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/iamcco/markdown-preview.nvim',
})

require('utils').ensure_installed({ 'marksman', 'prettier', 'markdownlint-cli2' })
require('nvim-treesitter').install({ 'markdown' })
require('conform').formatters_by_ft.markdown = { 'prettier' }
require('lint').linters_by_ft.markdown = { 'markdownlint-cli2' }
require('render-markdown').setup({
  html = { enabled = false },
  latex = { enabled = false },
  yaml = { enabled = false },
})

vim.lsp.enable('marksman')

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'markdown-preview.nvim' then
      vim.fn['mkdp#util#install']()
    end
  end,
})
