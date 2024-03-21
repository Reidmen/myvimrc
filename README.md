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



