return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    require("telescope").setup()
    pcall(require("telescope").load_extension, "fzf")
    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fbn", builtin.builtin, {})
    vim.keymap.set("n", "<leader>fgs", builtin.grep_string, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
    vim.keymap.set("n", "<leader>fof", builtin.oldfiles, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})

    vim.keymap.set("n", "<leader>fnf", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })
  end,
}
