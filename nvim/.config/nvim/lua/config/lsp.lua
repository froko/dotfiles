vim.lsp.enable('lua_ls')
vim.lsp.enable('astro')
vim.lsp.enable('marksman')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('ts-ls')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-p>', function()
        vim.lsp.completion.get()
      end)
    end
  end,
})

vim.diagnostic.config({
  virtual_lines = true,
})
