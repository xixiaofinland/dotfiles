# append rust
PATH="$HOME/.cargo/bin/:$PATH"

# add ZSH
export ZSH="$HOME/.oh-my-zsh"


# ZSH_THEME="robbyrussell"
ZSH_THEME="ys"


# Load plugins
plugins=(git nvm npm fzf z)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZSH/oh-my-zsh.sh

# Load alias file
if [ -f ~/.config/zsh/.zsh_alias ]; then
    source ~/.config/zsh/.zsh_alias
else
    print "404: ~/.config/zsh/.zsh_alias not found."
fi
