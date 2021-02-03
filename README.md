# ZSH config

## Create symlink
```sh
ln -s dotfiles/zshutil ~/.zshutil
ln -s dotfiles/zshrc ~/.zshrc
```


# Emacs Config

## Create symlink
```sh
ln -s dotfiles/emacs.d ~/.emacs.d
```

## Prerequisites
### use-package
Opening emacs for the first time after linking to the config won't load any
package. `use-package` needs to be installed manually first.
`M-x package-install<RET>`
`use-package<RET>`

Close and re-open emacs.

### The Silver Searcher
`s-f` and `s-F` is bound to search in the file and search across the project
using the-silver-searcher (`ag`).

Install ag by following the instructions from [here](https://github.com/ggreer/the_silver_searcher)

### fzf
`s-O` is bound to `helm-fzf-project-root` (find file in project root) which requries fzf

Install fzf by following the instructions from [here](https://github.com/junegunn/fzf/blob/master/README.md#installation) for your platform.

## Setup ripgrep
If you want to use ripgrep as the base command for the helm-ag plugin, symlink
the `rg-wrapper` script to /usr/local/bin/rg-wrapper.

```sh
brew install ripgrep
ln -s dotfiles/rg-wrapper /usr/local/bin/.
```

Add the following under `:config` of `use-package helm-ag`


```
(setq helm-ag-base-command "rg-wrapper --vimgrep --no-heading --smart-case")
```

## Configure projects
This config use projectile for project management. To configure projectile to
make it aware of the project directories, this config uses magit primarily to
get the list of project directories.

List the project directories or a parent directory which contains the project
directories [here](https://github.com/susindaran/dotfiles/blob/master/emacs.d/init.el#L66).
The notation is `("/path/to/dir" . <depth of project dirs>)`
For example, if the directory `~/projects/` has the project directories then
the listing should be `("~/projects/" . 2)`.

If there is a directory which is not a git project (no `.git` present), then
create an empty `.projectile` file in the directory to be addes and add the
path to the directory [here](https://github.com/susindaran/dotfiles/blob/master/emacs.d/init.el#L127).

Close and re-open emacs (or `M-x eval-buffer`).

### Treemacs
Treemacs is used as the file-explorer. Use `M-x treemacs-projectile` to add
projects to the workspace. This is a one time setup.

# Vim Config
```sh
ln -s dotfiles/vimrc ~/.vimrc
```
