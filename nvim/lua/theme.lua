return {
  -- See colorschemes already installed `:Telescope colorscheme`.
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
