return { -- Autoformat
  "stevearc/conform.nvim",
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local disable_filetypes = { bash = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      -- go = { "goimports", "gofmt" },
    },
  },
}
