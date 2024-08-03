# Dotfiles 

Dotfiles (backup) for vim, neovim, git, tmux, and helix. 
Includes:
* `.vimrc` configuration with classic goodies for a basic *vim/python/c++* experience. Nothing fancy, will work in any HPC.
* `init.lua` for nvim including LSP configurations for Go, Python and C++. It includes `conform` for formatting.
* `tmux.conf` for tmux configuration. Also, very basic, straight to the point.
* `gitconfig` configuration for a pleasing visualization of the git history.

It requires [Nerd Font](https://www.nerdfonts.com/) for the icons.


## Fetch for Vim (stable vim)
```bash
cd $HOME
cp vimrc .vimrc
```

## Fetch NeoVim
```bash
mkdir -p ~/.config
git clone origin https://github.com/Reidmen/myvimrc.git  ~/.config/
```

## Requirements dotfiles for NeoVim 
Install `unzip` and `clang`. To do so, run the command:
```bash
# Unzip and clang compiler
sudo apt install unzip clang bat fzf
```

## Fuzzy finder with bat
Install `bat` and `fzf` for a fuzzy finder. A nice alias (for your `.bash_aliases`) is provided below:

```bash
fzv() {
  local results=$(fzf --preview 'batcat --color=always {}')
  [ -z $results ] && return
  echo "$results"
  nvim "$results"
}
```

### Optional
For LSP, `node` and `npm` are required for `pyright`, run the following command install them:

```bash
# nodejs  and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 20
node -v # should print `v20.13.0`
npm -v # should print `10.5.2`
```
