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
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sk", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    vim.keymap.set("n", "<leader>th", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })
    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[S]earch [/] in Open Files" })

    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })
  end,
}
