return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "bash", "c", "cpp", "lua", "markdown", "vim", "vimdoc", "python" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    -- Configure Treesitter `:help nvim-treesitter`
    require("nvim-treesitter.configs").setup(opts)
  end,
}
