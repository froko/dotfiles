-- Make visuals more appealing
vim.o.winborder = 'rounded'

-- Don't show mode
vim.o.showmode = false

-- Use relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.opt.undofile = true

-- Tab settings
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching unless or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- Folding settings
vim.api.nvim_create_autocmd({ 'FileType' }, {
  callback = function()
    local coding_plugins_loaded, parser = pcall(require, 'nvim-treesitter.parsers')

    if (coding_plugins_loaded == true) and parser.has_parser() then
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    else
      vim.opt.foldmethod = 'syntax'
    end
  end,
})

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = false

-- Disable built-in providers to speed up startup time
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
