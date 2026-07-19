return {
    "neovim/nvim-lspconfig", -- still required: it provides the lsp/*.lua configs
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
        update_in_insert = false,
        float = {
          border = "rounded",
          source = true,
        },
      })
      vim.opt.completeopt = { "menu", "menuone", "noinsert", "popup" }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user.lsp", { clear = true }),

        callback = function(event)
          local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
          local opts = { buffer = event.buf }

          -- Shared keymaps for every attached language server.
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

          -- Built-in Neovim completion.
          if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, {
              autotrigger = true,
            })
          end
        end,
      })

      -- elixirls: brew symlinks language_server.sh -> `elixir-ls` on PATH, but
      -- lspconfig has no default cmd, so wire it explicitly.
      vim.lsp.config("elixirls", {
        cmd = { "elixir-ls" },
        settings = { elixirLS = { dialyzerEnabled = true, fetchDeps = false } },
      })
      vim.lsp.config("rust_analyzer", {
        settings = { ["rust-analyzer"] = { check = { command = "clippy" } } },
      })
      vim.lsp.config("gopls", {
        settings = { gopls = { gofumpt = true, staticcheck = true } },
      })
      vim.lsp.config("zls", {})

      vim.lsp.enable({ "rust_analyzer", "gopls", "elixirls", "zls"})
    end,
  }
