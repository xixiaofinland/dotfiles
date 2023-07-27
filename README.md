### Depend

The repo is configured based on [the best way to store/restore your dotfiles](https://www.atlassian.com/git/tutorials/dotfiles).

### How to restore

1. go to your $HOME, echo ".cfg" >> .gitignore (There could be weird behaviour if .cfg tries to track itself. Avoid recursive issues by adding .cfg to your global Git ignore)
2. git clone git@github.com:xixiaofinland/dotfiles.git$HOME/.cfg --bare
3. alias config='/usr/bin/git --git-dir=$HOME/.cfg/  --work-tree=$HOME'
4. config config --local status.showUntrackedFiles no
5. config checkout (make sure no files with same name existing, otherwise checkout action will fail)


Nvim related:

- [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.

- Prettier, Apex-Prettier - formatting

- sfapex-treesitter - syntax highlight

- apex LSP.jar - code jumpping etc.
