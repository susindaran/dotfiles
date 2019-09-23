# Emacs Config

## Create symlink to config
```sh
ln -s dotfiles/emacs.d ~/.emacs.d
```

## Setup ripgrep
If you want to use ripgrep as the base command for the helm-ag plugin, symlink
the `rg-wrapper` script to /usr/local/bin/rg-wrapper.

```sh
brew install ripgrep
ln -s dotfiles/rg-wrapper /usr/local/bin/.
```

## Install prerequisite
Opening emacs for the first time after linking to the config won't load any
package. `use-package` needs to be installed manually first.
`M-x package-install<RET>`
`use-package<RET>`

Close and re-open emacs.

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

# Vim Config
```sh
ln -s dotfiles/vimrc ~/.vimrc
```
