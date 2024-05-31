return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "bash", "c", "lua", "markdown", "vim", "vimdoc", "python" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, options)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    require("nvim-treesitter.configs").setup(options)
  end,
}
