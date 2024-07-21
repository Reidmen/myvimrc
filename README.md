# Dotfiles 

Personal dotfiles for backup purposes for git, vim and neovim.
Includes `.vimrc` configuration, `init.lua` config., `tmux.conf` and `gitconfig`.
They require [Nerd Font](https://www.nerdfonts.com/) to execute properly.


## Fetch vimrc (stable vim)
```bash
cd $HOME
cp vimrc .vimrc
```

## Fetch from another machine (nvim)
```bash
mkdir -p ~/.config
git clone origin https://github.com/Reidmen/myvimrc.git  ~/.config/
```

## LazyVim make details (lua)

```lua
{
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    enabled = vim.fn.executable("make") == 1,
    config = function()
      Util.on_load("telescope.nvim", function()
        require("telescope").load_extension("fzf")
      end)
    end,
  },
```

## Requirements for using the `init.lua`
For `init.lua` to be installed properly, some dependencies must be installed.
To install `Unzip` and `clang`, run the following command:
```bash
# Unzip and clang compiler
sudo apt install unzip clang
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
