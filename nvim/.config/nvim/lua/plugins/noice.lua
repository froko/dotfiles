local nnoremap = require('utils').nnoremap

return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      nnoremap('<leader>nn', function()
        require('notify').dismiss()
      end, { desc = 'Dismiss notifications' })
      nnoremap('<leader>nc', ':NotificationsClear<CR>', { desc = '[N]otifications [C]lear' })

      require('notify').setup({
        background_colour = '#000001',
      })
      require('noice').setup({
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
        },
      })
    end,
  },
}
