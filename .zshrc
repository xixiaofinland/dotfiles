# Launch or re-attach
# session_name="xixiao"
#
# tmux has-session -t=$session_name 2> /dev/null
#
# if [[ $? -ne 0 ]]; then
#   TMUX='' tmux new-session -d -s "$session_name"
# fi
#
# if [[ -z "$TMUX" ]]; then
#     tmux attach -t "$session_name"
# else
#     tmux switch-client -t "$session_name"
# fi

# Append rust commands
PATH="$HOME/.cargo/bin/:$PATH"

# Append Haskell commands
PATH="$HOME/.local/bin/:$PATH"

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
        alias fd="fdfind"
        export PATH="/snap/bin:$PATH"
    ;;
esac

# Load plugins
plugins=(git nvm npm fzf z zsh-autosuggestions)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
export LANG="en_US.UTF-8"

# esp32
export IDF_PATH="$HOME/esp/esp-idf"
export PATH="$PATH:$IDF_PATH/tools"
# esp32-idf refresh
alias get_idf='. $IDF_PATH/export.sh'

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"

# Load extra setting files
if [ -f ~/.config/zsh/.zsh_alias ]; then
    source ~/.config/zsh/.zsh_alias
else
    print "404: ~/.config/zsh/.zsh_alias not found."

fi

ZSH_THEME=""
# manually install pure theme by:
# mkdir -p "$HOME/.zsh"
# git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure


if [ -e /home/finxxi/.nix-profile/etc/profile.d/nix.sh ]; then . /home/finxxi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
