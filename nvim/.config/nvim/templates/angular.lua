-- templates/angular.lua
--
-- Angular support: LSP (angularls), template highlighting, formatting,
-- and linting for both component classes and HTML templates.
--
-- HTML templates use Neovim's built-in `htmlangular` filetype. The
-- `angular` Treesitter parser provides highlighting for them, the
-- angularls server provides completion/diagnostics (wired in
-- lsp/angularls.lua), and prettier formats them.

-- ── Mason: ensure Angular language server is installed ───────────────

require('utils').ensure_installed({ 'angular-language-server' })

-- ── Treesitter ───────────────────────────────────────────────────────
-- `angular` is the injection parser registered for the `htmlangular`
-- filetype; `html` backs plain `.html` templates.

require('nvim-treesitter').install({ 'angular', 'html' })

-- ── Formatting (conform.nvim) ────────────────────────────────────────
-- Prettier formats Angular HTML templates (it auto-selects its `angular`
-- parser for `*.component.html`). oxfmt handles the TS component classes
-- via templates/web.lua already, so only the template filetypes are added
-- here.

local formatters_by_ft = require('conform').formatters_by_ft
formatters_by_ft.htmlangular = { 'prettier' }

-- ── Linting ──────────────────────────────────────────────────────────
-- Run the configured web linters (oxlint/eslint) on Angular templates.

require('utils').setup_web_lint_autocmd({ '*.component.html' })

-- ── angularls capability tweaks ──────────────────────────────────────
-- Let vtsls own go-to-definition / find-references for TS symbols so we
-- don't get duplicate results from both servers; angularls keeps its
-- template-specific intelligence (completion, diagnostics, hovers).

vim.lsp.config('angularls', {
  on_attach = function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    local is_ts = ft == 'typescript' or ft == 'typescriptreact'
    client.server_capabilities.referencesProvider = not is_ts
    client.server_capabilities.definitionProvider = not is_ts
  end,
})

-- ── Enable Angular language server ───────────────────────────────────

vim.lsp.enable('angularls')
