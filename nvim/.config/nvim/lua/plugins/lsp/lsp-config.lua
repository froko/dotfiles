local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'folke/lazydev.nvim', opts = {} },
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local mason_lspconfig = require 'mason-lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = 'Show LSP references'
        nnoremap('gR', '<cmd>Telescope lsp_references<CR>', opts)

        opts.desc = 'Go to declaration'
        nnoremap('gD', vim.lsp.buf.declaration, opts)

        opts.desc = 'Show LSP definitions'
        nnoremap('gd', '<cmd>Telescope lsp_definitions<CR>', opts)

        opts.desc = 'Show LSP implementations'
        nnoremap('gi', '<cmd>Telescope lsp_implementations<CR>', opts)

        opts.desc = 'Show LSP type definitions'
        nnoremap('gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

        opts.desc = 'See available code actions'
        nnoremap('<leader>ca', vim.lsp.buf.code_action, opts)
        vnoremap('<leader>ca', vim.lsp.buf.code_action, opts)

        opts.desc = 'Smart rename'
        nnoremap('<leader>rn', vim.lsp.buf.rename, opts)

        opts.desc = 'Show buffer diagnostics'
        nnoremap('<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

        opts.desc = 'Show line diagnostics'
        nnoremap('<leader>d', vim.diagnostic.open_float, opts)

        opts.desc = 'Go to previous diagnostic'
        nnoremap('[d', vim.diagnostic.goto_prev, opts)

        opts.desc = 'Go to next diagnostic'
        nnoremap(']d', vim.diagnostic.goto_next, opts)

        opts.desc = 'Show documentation for what is under cursor'
        nnoremap('K', vim.lsp.buf.hover, opts)

        opts.desc = 'Restart LSP'
        nnoremap('<leader>rs', ':LspRestart<CR>', opts)
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs =
      { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    local omnisharpAssembly = os.getenv 'OMNISHARP'
      or '~/.omnisharp/OmniSharp.dll'
    local pid = vim.fn.getpid()
    mason_lspconfig.setup_handlers {
      function(server_name)
        lspconfig[server_name].setup { capabilities = capabilities }
      end,
      ['omnisharp'] = function()
        lspconfig['omnisharp'].setup {
          capabilities = capabilities,
          cmd = {
            'dotnet',
            omnisharpAssembly,
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
      end,
      ['lua_ls'] = function()
        lspconfig['lua_ls'].setup {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { 'vim' } },
              completion = { callSnippet = 'Replace' },
            },
          },
        }
      end,
    }
  end,
}
