# Jetbrains

I use Jetbrains Rider for C# development at work. This directory contains the
`.ideavimrc` file to enable Vim keybindings in Rider and enhance it with some
additional features. Please note that the `.ideavimrc` file includes the
`.vimrc` file. Both files must be placed in the home directory to work properly:

```bash
cd ~/dotfiles
ln -s jetbrains/.ideavimrc ~/.ideavimrc
ln -s vim/.vimrc ~/.vimrc
```

## Rider Plugins

- Catppuccin Theme: A beautiful theme for Rider that enhances the appearance of
  the IDE.
- IdeaVim: A plugin that enables Vim keybindings in Rider, allowing for a more
  efficient and familiar editing experience for Vim users.
- vim-flash: A plugin that provides a search and jump functionality similar to
  the Vim flash plugin, allowing for quick navigation within the codebase.
