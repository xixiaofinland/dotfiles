# launch TMUX automatically at start
if [ "$TMUX" = "" ]; then tmux; fi

# Append rust commands
PATH="$HOME/.cargo/bin/:$PATH"

# Add oh-my-zsh to path
export ZSH="$HOME/.oh-my-zsh"


# OS specific
case `uname` in
    Darwin)

        # Rust
        export PATH=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib:$PATH
        export LIBRARY_PATH="$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"

        # brew
        . $(brew --prefix)/etc/profile.d/z.sh

        # Python
        # export PATH=/Users/xixiao/Library/Python/3.8/bin:$PATH
        # export PATH="$PATH:/usr/local/bin/phantomjs"
        # command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
        # eval "$(pyenv init -)"

        #Ruby
        # source /usr/local/opt/chruby/share/chruby/chruby.sh
        # source /usr/local/opt/chruby/share/chruby/auto.sh
        # chruby ruby-3.1.2
        # export PATH="/usr/local/opt/mysql-client/bin:$PATH"
    ;;
    Linux)
    ;;
esac

ZSH_THEME="ys"

# Load plugins
plugins=(git nvm npm fzf z)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Load extra setting files
if [ -f ~/.config/zsh/.zsh_alias ]; then
    source ~/.config/zsh/.zsh_alias
else
    print "404: ~/.config/zsh/.zsh_alias not found."
fi

# run only when no other zsh process is running
[[ "$(pidof zsh)" == *' '* ]] || config pull
