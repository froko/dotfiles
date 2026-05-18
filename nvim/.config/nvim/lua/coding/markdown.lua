-- lua/coding/markdown.lua
--
-- Markdown support: LSP (marksman), formatting (prettier), linting
-- (markdownlint-cli2), in-editor rendering, and browser preview.

-- ── Plugin declarations ──────────────────────────────────────────────

vim.pack.add({
  'https://github.com/MeanderingProgrammer/render-markdown.nvim', -- in-editor rendering
  'https://github.com/iamcco/markdown-preview.nvim', -- browser preview (:MarkdownPreview)
})

-- ── Tooling ──────────────────────────────────────────────────────────

require('utils').ensure_installed({ 'marksman', 'prettier', 'markdownlint-cli2' })
require('nvim-treesitter').install({ 'markdown' })
require('conform').formatters_by_ft.markdown = { 'prettier' }
require('lint').linters_by_ft.markdown = { 'markdownlint-cli2' }

-- ── Render-markdown (in-editor) ──────────────────────────────────────
-- Disable features we don't need to keep things fast.

require('render-markdown').setup({
  html = { enabled = false },
  latex = { enabled = false },
  yaml = { enabled = false },
})

-- ── LSP ──────────────────────────────────────────────────────────────

vim.lsp.enable('marksman')

-- ── Markdown-preview (browser) ───────────────────────────────────────
-- Auto-install the preview binary when the plugin is first added/updated.

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'markdown-preview.nvim' then
      vim.fn['mkdp#util#install']()
    end
  end,
})
