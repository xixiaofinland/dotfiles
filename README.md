# What

The repo is configured based on [the best way to store/restore your dotfiles](https://www.atlassian.com/git/tutorials/dotfiles).

### Feature

- zsh
- tmux
- nvim

### How to restore

1. `echo ".cfg" >> ~/.gitignore` (in case recursive load issue)
2. `git clone git@github.com:xixiaofinland/dotfiles.git $HOME/.cfg --bare`
3. `alias config='/usr/bin/git --git-dir=$HOME/.cfg/  --work-tree=$HOME'`
4. `config config --local status.showUntrackedFiles no`
5. `config checkout`


Nvim related:

- [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.

- Prettier, Apex-Prettier - formatting

- sfapex-treesitter - syntax highlight

- apex LSP.jar - code jumpping etc.
