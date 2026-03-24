local nnoremap = require('utils').nnoremap

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/neotest-jest',
    'thenbe/neotest-playwright',
  },
  config = function()
    -- Helper to find jest config in Nx monorepo
    local function find_jest_config(file)
      local config = vim.fn.findfile('jest.config.ts', vim.fn.fnamemodify(file, ':p:h') .. ';')
      return config ~= '' and config or nil
    end

    require('neotest').setup({
      adapters = {
        require('neotest-jest')({
          env = { CI = true },
          jestConfigFile = function(file)
            local config = find_jest_config(file)
            return config and vim.fn.fnamemodify(config, ':p') or vim.fn.getcwd() .. '/jest.config.ts'
          end,
          cwd = function(file)
            local config = find_jest_config(file)
            return config and vim.fn.fnamemodify(config, ':p:h') or vim.fn.getcwd()
          end,
          isTestFile = function(file_path)
            if not file_path then
              return false
            end
            local is_jest_pattern = file_path:match('%.spec%.')
            local is_e2e = file_path:match('/e2e/')
            return is_jest_pattern and not is_e2e
          end,
        }),
        require('neotest-playwright').adapter({
          is_test_file = function(file_path)
            if not file_path then
              return false
            end
            local is_playwright_pattern = file_path:match('%.spec%.')
            local is_e2e = file_path:match('/e2e/')
            return is_playwright_pattern and is_e2e
          end,
        }),
      },
    })

    local neotest = require('neotest')
    nnoremap('<leader>af', function()
      neotest.run.run(vim.fn.expand('%'))
    end, {
      desc = 'Test File',
    })
    nnoremap('<leader>aa', function()
      neotest.run.run()
    end, {
      desc = 'Test Nearest',
    })
    nnoremap('<leader>as', function()
      neotest.summary.toggle()
    end, {
      desc = 'Toggle Test Summary',
    })
    nnoremap('<leader>ao', function()
      neotest.output.open({ enter = true })
    end, {
      desc = 'Show Test Output',
    })
  end,
}
