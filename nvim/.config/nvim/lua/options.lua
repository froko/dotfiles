-- lua/options.lua
--
-- Global Neovim options. Loaded before any plugins.

-- ── Leader key ───────────────────────────────────────────────────────

vim.g.mapleader = ' '

-- ── UI ───────────────────────────────────────────────────────────────

vim.o.winborder = 'rounded'
vim.o.showmode = false -- hidden because lualine shows the mode
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.scrolloff = 8 -- keep 8 lines visible above/below cursor

-- ── Input ────────────────────────────────────────────────────────────

vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus' -- use system clipboard

-- ── Persistence ──────────────────────────────────────────────────────

vim.opt.swapfile = false
vim.opt.undofile = true -- persistent undo across sessions

-- ── Indentation ──────────────────────────────────────────────────────

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.breakindent = true -- wrapped lines continue visually indented

-- ── Search ───────────────────────────────────────────────────────────

vim.o.ignorecase = true
vim.o.smartcase = true -- case-sensitive when uppercase is used
vim.o.inccommand = 'split' -- live preview of :s substitutions

-- ── Splits ───────────────────────────────────────────────────────────

vim.o.splitright = true
vim.o.splitbelow = true

-- ── Misc ─────────────────────────────────────────────────────────────

vim.o.confirm = true -- ask to save instead of failing on :q

-- ── Spelling ─────────────────────────────────────────────────────────

vim.o.spelllang = 'en_us,de_ch'
vim.o.spellsuggest = 'best,9'

-- ── Folding (Treesitter-based) ───────────────────────────────────────

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = ''
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = '1'

-- ── Disabled built-in providers ──────────────────────────────────────
-- Speeds up startup by skipping provider health checks.

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
