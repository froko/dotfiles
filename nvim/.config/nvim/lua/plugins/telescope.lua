local nnoremap = require("utils").nnoremap

return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local builtin = require("telescope.builtin")
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    nnoremap("<leader>f.", function()
      builtin.find_files({ cwd = "~/dotfiles", hidden = true })
    end, { desc = "dotfiles" })

    nnoremap("<leader>fb", function()
      builtin.buffers({ sort_mru = true, sort_lastused = true, initial_mode = "normal" })
    end, { desc = "Buffers" })

    telescope.setup({
      defaults = {
        mappings = {
          n = {
            ["d"] = actions.delete_buffer,
            ["q"] = actions.close,
          },
        },
      },
    })
  end,
}
