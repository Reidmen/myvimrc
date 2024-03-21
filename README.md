## myvimrc and tmux

Stores my .vimrc configuration, and tmux for reference purposes.
They require [Nerd Font](https://www.nerdfonts.com/) to execute properly.


# Fetch vimrc (stable vim)
```

```

# Fetch from another machine (nvim)
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



