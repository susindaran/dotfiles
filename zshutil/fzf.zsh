# export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
# use the above setting if you want to use ripgrep to feed the files to fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --ignore-file '$HOME/.gitignore'"
export FZF_CTRL_T_COMMAND="fd --type f --hidden --ignore-file '$HOME/.gitignore'"
export FZF_ALT_C_COMMAND="fd --type d --hidden --ignore-file '$HOME/.gitignore'"

# fzf.zsh is autogenerated by fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
