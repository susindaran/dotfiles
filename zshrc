# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
ZSH_THEME="powerlevel10k/powerlevel10k"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
  battery
  bundler
  dotenv
  macos
  rbenv
  ruby
  # https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
  zsh-autosuggestions
)

ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

case "$(uname -s)" in

   Darwin)
     autoload -Uz compinit; compinit
     autoload -Uz bashcompinit; bashcompinit
     source ~/.bashrc
     source ~/.bash_profile
     eval "$(nodenv init -)"
     compdef _git stripe-git=git # this line specifically will fix git autocompletion
     ;;

   Linux)
     # Set linux specific settings
     ;;

   *)
     echo 'Other OS'
     ;;
esac

function tmux-new() {
    tmux new -s $1
}

function tmux-attach() {
    tmux attach-session -t $1
}

delete_directory() {
  local DIR=$1
  if [ -d "$DIR" ]; then
    echo "Deleting directory $DIR"
    du -sh "$DIR"
    rm -rf "$DIR" && echo "Deleted $DIR."
  else
    echo "Directory $DIR does not exist."
  fi
}

git_garbage_collect() {
  local DIR=$1
  if [ -d "$DIR" ]; then
    echo "Running 'git gc --aggressive --prune=now' in $DIR"
    git -C "$DIR" gc --aggressive --prune=now
  else
    echo "$DIR is not a Git repository."
  fi
}

alias weather="curl http://v2.wttr.in -s"
alias gcm="git commit -m"
alias chardiff="git diff --no-index --word-diff=color --word-diff-regex=."
# checkout master and pull
alias mp="git checkout master && git pull origin master"
alias ems="emacs --daemon"
alias em="emacsclient -a '' -c"
alias kill-emacs="emacsclient -e '(kill-emacs)'"
alias c="clear"
alias rgol="rg --no-heading --line-number"

# Set emacsclient to be default editor
export EDITOR="emacsclient -a '' -c"

[ -f ~/.zshutil/fzf.zsh ] && source ~/.zshutil/fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.zshutil/p10k.zsh
[[ ! -f ~/.zshutil/p10k.zsh ]] || source ~/.zshutil/p10k.zsh

# For ubuntu, use this instead
# [[ ! -f ~/.zshutil/p10k-ubuntu.zsh ]] || source ~/.zshutil/p10k-ubuntu.zsh
