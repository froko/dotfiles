-- lua/coding/lsp.lua
--
-- Global LSP behavior: keymaps on attach, completion fallback,
-- and error suppression for known noisy LSP error codes.

-- ── LSP keymaps (set on every LspAttach) ─────────────────────────────

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local fzf = require('fzf-lua')
    local nnoremap = require('utils').nnoremap

    --- Open code actions picker, filtering out disabled actions.
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

    -- Fallback: if blink.cmp is not installed, use built-in LSP completion
    local has_blink, _ = pcall(require, 'blink.cmp')
    if not has_blink then
      vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

-- ── Error suppression ────────────────────────────────────────────────
-- Suppress LSP error code -32603 (internal server error) which some
-- servers emit spuriously without affecting functionality.

local notify = vim.notify
vim.notify = function(msg, level, opts)
  if msg:find('-32603') then
    return
  end
  notify(msg, level, opts)
end

-- ── Completion options ───────────────────────────────────────────────

vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
