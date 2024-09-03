local nnoremap = require("utils").nnoremap

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    ui = { enable = false },
    dir = os.getenv("OBSIDIANDIR") or "~/Work/2ndBrain",
    notes_subdir = "0-Inbox",
    new_notes_location = "notes_subdir",
    disable_frontmatter = true,
    templates = {
      folder = "__Templates",
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
    nnoremap("<Leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Obsidian: Backlinks" })
    nnoremap(
      "<Leader>on",
      '<cmd>ObsidianTemplate Inbox<CR> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>")',
      { desc = "Obsidian: New Note" }
    )
    nnoremap("<leader>of", ":s/-/ /g<cr>", { desc = "Obsidian: Format" })
    nnoremap("<Leader>ot", "<cmd>ObsidianTags<CR>", { desc = "Obsidian: Tags" })
  end,
}
