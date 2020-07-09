# export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
# use the above setting if you want to use ripgrep to feed the files to fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --ignore-file '$HOME/.gitignore'"
export FZF_CTRL_T_COMMAND="fd --type f --hidden --ignore-file '$HOME/.gitignore'"
export FZF_ALT_C_COMMAND="fd --type d --hidden --ignore-file '$HOME/.gitignore'"

# fzf.zsh is autogenerated by fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# Preview commits from git log
preview-commits() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf --height 50% --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort,alt-p:preview-up,alt-n:preview-down' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}
