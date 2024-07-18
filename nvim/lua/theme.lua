return {
  -- See colorschemes already installed `:Telescope colorscheme`.
  "navarasu/onedark.nvim",
  -- "blazkowolf/gruber-darker.nvim",
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme
    vim.cmd.colorscheme("onedark")
    -- vim.cmd.colorscheme("gruber-darker")
    -- vim.cmd.hi("Comment gui=none")
  end,
  config = function()
    require("onedark").setup({ style = "deep" })
  end,
}
