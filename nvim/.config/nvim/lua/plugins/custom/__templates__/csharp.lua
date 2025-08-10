vim.lsp.enable('csharp-ls')

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      local tools = { 'csharp-language-server', 'csharpier' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, tools)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      local parsers = { 'c_sharp' }
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, parsers)
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local formatters = { cs = { 'csharpier' } }
      opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, formatters)
      opts.formatters = {
        csharpier = function()
          local use_dotnet = vim.fn.executable('csharpier') == 0
          local command = use_dotnet and 'dotnet' or 'csharpier'
          local args = use_dotnet and { 'csharpier', 'format', '$FILENAME' } or { 'format', '$FILENAME' }
          return {
            command = command,
            args = args,
            stdin = false,
            require_cwd = false,
          }
        end,
      }
    end,
  },
}
