return {
  -- "echasnovski/mini.nvim",
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local statusline = require("lualine")
    statusline.setup({
      options = { component_separators = " ", section_separators = " " },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "filename", "branch", "buffer" },
        lualine_c = { "diagnostic", "require'lsp-status'.status", "diff" },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
