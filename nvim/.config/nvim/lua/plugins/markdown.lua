return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    build = 'cd app && pnpm install',
    cmd = {
      'MarkdownPreview',
      'MarkdownPreviewStop',
      'MarkdownPreviewToggle',
      'MarkdownPreviewRefresh',
    },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_refresh_slow = 1
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_page_title = '${name}'
      vim.g.mkdp_theme = 'dark'
    end,
  }
}
