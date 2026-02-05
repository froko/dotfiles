local nnoremap = require('utils').nnoremap

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-jest',
    'thenbe/neotest-playwright',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-playwright').adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
          is_test_file = function(file_path)
            -- Only match test files (spec/test) that are in e2e directories
            return file_path:find('e2e') ~= nil
                and (file_path:match('%.spec%.[jt]sx?$')
                  or file_path:match('%.test%.[jt]sx?$')
                  or file_path:match('%.spec%.[mc][jt]s$')
                  or file_path:match('%.test%.[mc][jt]s$'))
          end,
        }),
        require('neotest-jest')({
          env = { CI = true },
          jestConfigFile = function(file)
            if string.find(file, '/apps/') or string.find(file, '/libs/') then
              return vim.fn.findfile('jest.config.ts', file .. ';')
            end
            return vim.fn.getcwd() .. '/jest.config.ts'
          end,
          cwd = function(file)
            if string.find(file, '/apps/') or string.find(file, '/libs/') then
              return vim.fn.fnamemodify(
                vim.fn.findfile('jest.config.ts', file .. ';'), ':p:h')
            end
            return vim.fn.getcwd()
          end,
          filter_dir = function(name)
            -- Exclude e2e directories from jest
            return name.find('e2e') == nil
          end,
        }),
      },
    })

    local neotest = require('neotest')
    nnoremap('<leader>tt', function()
      neotest.run.run()
    end, {
      desc = 'Run Nearest',
    })
    nnoremap('<leader>tf', function()
      neotest.run.run(vim.fn.expand('%'))
    end, {
      desc = 'Run File',
    })
    nnoremap('<leader>ts', function()
      neotest.summary.toggle()
    end, {
      desc = 'Toggle Summary',
    })
    nnoremap('<leader>to', function()
      neotest.output.open({ enter = true })
    end, {
      desc = 'Show Output',
    })
  end,
}
