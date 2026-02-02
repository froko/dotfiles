vim.lsp.enable('marksman')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(args)
    vim.treesitter.start(args.buf, 'markdown')
  end,
})

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      local tools = { 'marksman', 'markdownlint-cli2' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, tools)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      local parsers = { 'markdown', 'markdown_inline' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, parsers)
      return opts
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local formatters = { markdown = { 'prettier' } }
      opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, formatters)
    end,
  },
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      local linters = { markdown = { 'markdownlint-cli2' } }
      opts.linters_by_ft = vim.tbl_deep_extend('force', opts.linters_by_ft or {}, linters)
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = { latex = { enabled = false } },
    config = function(_, opts)
      require('render-markdown').setup(opts)
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_preview_options = {
        uml = { server = 'http://localhost:8080' },
      }
    end,
    ft = { 'markdown' },
  },
}
