return {
  -- See colorschemes already installed, use `:Telescope colorscheme`.
  -- 'folke/tokyonight.nvim',
  "navarasu/onedark.nvim",
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    -- 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    -- vim.cmd.colorscheme 'tokyonight-night'
    vim.cmd.colorscheme("onedark")
    vim.cmd.hi("Comment gui=none")
  end,
  config = function()
    require("onedark").setup({ style = "darker" })
  end,
  lazy = false,
}
