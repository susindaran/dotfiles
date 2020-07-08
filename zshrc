autoload -Uz compinit; compinit
autoload -Uz bashcompinit; bashcompinit
source ~/.bash_profile
source ~/.bashrc

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Enable zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh/"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="pi"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
  battery
  bundler
  dotenv
  osx
  rbenv
  ruby
)

source $ZSH/oh-my-zsh.sh

function tmux-new() {
    tmux new -s $1
}

function tmux-attach() {
    tmux attach-session -t $1
}

alias weather="curl http://v2.wttr.in -s"
alias gcm="git commit -m"
alias chardiff="git diff --no-index --word-diff=color --word-diff-regex=."
# checkout master and pull
alias mp="git checkout master && git pull origin master"
alias ems="emacs --daemon"

[ -f ~/.zshutil/fzf.zsh ] && source ~/.zshutil/fzf.zsh
