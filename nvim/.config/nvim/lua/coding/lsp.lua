vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local fzf = require('fzf-lua')
    local nnoremap = require('utils').nnoremap

    local function filtered_code_actions()
      fzf.lsp_code_actions({
        previewer = false,
        winopts = { width = 0.60 },
        filter = function(action)
          return action.disabled == nil or not action.disabled
        end,
      })
    end

    nnoremap('gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: Go to definition' })
    nnoremap('gra', filtered_code_actions, { buffer = bufnr, desc = 'LSP: Code actions' })
    nnoremap('grr', fzf.lsp_references, { buffer = bufnr, desc = 'LSP: References' })

    local has_blink, _ = pcall(require, 'blink.cmp')
    if not has_blink then
      vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

local notify = vim.notify
vim.notify = function(msg, level, opts)
  if msg:find('-32603') then
    return
  end
  notify(msg, level, opts)
end

vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
