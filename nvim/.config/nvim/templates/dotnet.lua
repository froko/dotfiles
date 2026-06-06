-- templates/dotnet.lua
--
-- .NET / C# support: LSP (Roslyn via roslyn.nvim), formatting (csharpier),
-- and Treesitter. Requires the `dotnet` CLI to be available on PATH.
--
-- Linting note: Roslyn surfaces analyzer/compiler diagnostics through the
-- LSP itself (enabled below), so no separate nvim-lint linter is needed.

-- ── Plugin declarations ──────────────────────────────────────────────

vim.pack.add({
  'https://github.com/seblyng/roslyn.nvim', -- Roslyn LSP integration (replaces OmniSharp)
})

-- ── Mason registry ───────────────────────────────────────────────────
-- The `roslyn` package lives in the Crashdummyy registry (kept in sync with
-- the VS Code C# extension). Re-running mason.setup is idempotent and merges
-- the extra registry on top of the defaults configured in coding/init.lua.

require('mason').setup({
  registries = {
    'github:mason-org/mason-registry',
    'github:Crashdummyy/mason-registry',
  },
})

-- ── Tooling ──────────────────────────────────────────────────────────
-- `roslyn`    - C# language server (from the Crashdummyy registry)
-- `csharpier` - opinionated C# formatter

require('utils').ensure_installed({ 'roslyn', 'csharpier' })
require('nvim-treesitter').install({ 'c_sharp' })
require('conform').formatters_by_ft.cs = { 'csharpier' }

-- Start Treesitter on C# buffers. nvim-treesitter (main) does not auto-start
-- the parser per-filetype, so highlighting and Treesitter folding only work
-- once `vim.treesitter.start()` runs for the buffer.
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cs' },
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})

-- ── LSP (Roslyn) ─────────────────────────────────────────────────────
-- roslyn.nvim defines the `roslyn` lsp config and auto-detects the
-- Mason-installed binary. Analyzer/code-style diagnostics are enabled so
-- C# linting comes straight from the language server.

require('roslyn').setup({
  settings = {
    ['csharp|background_analysis'] = {
      dotnet_analyzer_diagnostics_scope = 'fullSolution',
      dotnet_compiler_diagnostics_scope = 'fullSolution',
    },
    ['csharp|code_lens'] = {
      dotnet_enable_references_code_lens = true,
    },
    ['csharp|inlay_hints'] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      dotnet_enable_inlay_hints_for_parameters = true,
    },
  },
})

vim.lsp.enable('roslyn')
