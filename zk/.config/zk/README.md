# zk

[zk](https://zk-org.github.io/zk/) is my plain text note-taking assistant. The
structure of my notes is inspired by the PARA method by Tiago Forte and the
Zettelkasten method.

## Structure

- Daily notes: Notes created for each day to capture tasks, events, and fleeting
  thoughts.
- Areas: Ongoing responsibilities and areas of focus in my life and work.
- Projects: Short-term efforts with a specific goal or outcome.
- Hubs: Central notes that backlink to related notes on a specific topic.
- Slides: Notes created for presentations using the
  [`slides`](https://maaslalani.com/slides/) command line tool.
- "Normal" notes: Depending on the tags used, these notes can belong to
  different categories: fleeting notes, literature notes, permanent notes,
  how-to notes, blog posts to be written, etc.

All notes have a tag list in their frontmatter. "Normal" notes come
preconfigured with a hub property in the frontmatter to be asociated with.

## Command Line Reference

### Create new notes

- `zk daily`: Creates or updates a daily note for today.
- `zk add My first Note`: Adds a new note with the title "My first Note".
- `zk area My area`: Adds a new area note with the title "My area".
- `zk project My project`: Adds a new project note with the title "My project".

### List notes

- `zk last`: Opens the most recently modified note.
- `zk recent`: Lists the notes created the last two weeks.
- `zk areas`: Lists all area notes.
- `zk projects`: Lists all project notes.
- `zk hubs`: Lists all hub notes.
- `zk slides`: Lists all slide notes to be opened using the
  [`slides`](https://maaslalani.com/slides/) command line tool.

### Manage notes

- `zk rm`: Removes an archived note selected from the `fzf` fuzzy finder.
- `zk update`: Commits all changes to the notes and pushes them to the remote
  Git repository.

## Important tags

For listing notes, there are some important tags to know about:

- `#area`: Marks an area note.
- `#project`: Marks a project note.
- `#hub`: Marks a hub note.
- `#slide`: Marks a slide note.
- `#archive`: Marks notes that are archived and not actively used.

## NeoVim support

`zk` comes with a [zk-nvim](https://github.com/zk-org/zk-nvim) plugin that
provides support for linking and tagging notes out of the box. To install it,
create a `zk.lua` file in your custom nvim plugin directory with the following
content:

```lua
local nnoremap = require('utils').nnoremap
local vnoremap = require('utils').vnoremap

return {
  'zk-org/zk-nvim',
  config = function()
    require('zk').setup({
      picker = 'fzf_lua',
      lsp = {
        config = {
          name = 'zk',
          cmd = { 'zk', 'lsp' },
          filetypes = { 'markdown' },
        },
        auto_attach = {
          enabled = true,
        },
      },
    })

    nnoremap('<leader>zb', '<Cmd>ZkBacklinks<CR>', { desc = 'Search Zk Backlinks' })
    nnoremap('<leader>zl', '<Cmd>ZkInsertLink<CR>', { desc = 'Add a Zk note as a link' })
    nnoremap('<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { desc = 'Create a new Zk note' })
    nnoremap('<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { desc = 'Open Zk notes' })
    nnoremap('<leader>zt', '<Cmd>ZkTags<CR>', { desc = 'Search Zk tags' })

    vnoremap('<leader>zf', ":'<,'>ZkMatch<CR>", { desc = 'Search Zk notes for visual selection' })
    vnoremap('<leader>zl', ":'<,'>ZkNewFromTitleSelection<CR>", { desc = 'Create a new linked Zk note' })
  end,
}
```
