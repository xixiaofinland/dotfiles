# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh" 

# append rust
PATH="$HOME/.cargo/bin/:$PATH"

# ZSH_THEME="robbyrussell"
ZSH_THEME="ys"


# Load plugins
plugins=(git nvm npm fzf z)

source $ZSH/oh-my-zsh.sh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Load alias file
if [ -f ~/.config/zsh/.zsh_alias ]; then
    source ~/.config/zsh/.zsh_alias
else
    print "404: ~/.config/zsh/.zsh_alias not found."
fi
