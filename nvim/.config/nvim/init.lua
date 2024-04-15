require 'options'
require 'keymaps'

require 'highlight_yank'
require 'resize-splits'
require 'vertical-help'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ { import = 'plugins' }, { import = 'plugins.lsp' } }, {
  install = { colorscheme = { 'catppuccin' } },
  ui = { border = 'double' },
  checker = { enabled = false, notify = false },
  change_detection = { notify = false },
})
