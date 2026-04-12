vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local fzf = require('fzf-lua')
    local nnoremap = require('utils').nnoremap

    nnoremap('gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: Go to definition' })
    nnoremap('grr', fzf.lsp_references, { buffer = bufnr, desc = 'LSP: References' })

    local has_blink, _ = pcall(require, 'blink.cmp')
    if not has_blink then
      vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
