return {
  "lewis6991/gitsigns.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
  config = function()
    require("gitsigns").setup()
    vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "[G]it [P]review" })
    vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "[G]git [B]lame" })
  end,
}
