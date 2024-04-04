return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup {
        ui = {
          border = 'double',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local omnisharp = '/Users/patrickineichen/.omnisharp/OmniSharp.dll'
      local pid = vim.fn.getpid()

      local lspconfig = require 'lspconfig'
      lspconfig.omnisharp.setup {
        capabilities = capabilities,
        cmd = {
          'dotnet',
          omnisharp,
          '--languageserver',
          '--hostPID',
          tostring(pid),
        },
        root_dir = function(fname)
          local primary = lspconfig.util.root_pattern '*.sln'(fname)
          local fallback = lspconfig.util.root_pattern '*.csproj'(fname)
          return primary or fallback
        end,
      }
      lspconfig.tsserver.setup {
        capabilities = capabilities,
      }
      lspconfig.html.setup {
        capabilities = capabilities,
      }
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = { Lua = { diagnostics = { globals = { 'vim', 'env' } } } },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set(
            'n',
            '<space>wa',
            vim.lsp.buf.add_workspace_folder,
            opts
          )
          vim.keymap.set(
            'n',
            '<space>wr',
            vim.lsp.buf.remove_workspace_folder,
            opts
          )
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set(
            { 'n', 'v' },
            '<space>ca',
            vim.lsp.buf.code_action,
            opts
          )
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  },
}
