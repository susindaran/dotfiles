# Emacs Config
```sh
ln -s emacs.d ~/.emacs.d
```
## Using ripgrep inside emacs
If you want to use ripgrep as the base command for the helm-ag plugin, symlink
the `rg-wrapper` script to /usr/local/bin/rg-wrapper.

```sh
ln -s ~/dotfiles/rg-wrapper /usr/local/bin/.
```