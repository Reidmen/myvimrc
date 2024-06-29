return { -- Autocompletion
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "L3MON4D3/LuaSnip",
    -- "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    -- See `:help cmp`
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup()

    require("luasnip.loaders.from_vscode").lazy_load()
    cmp.setup({
      completion = { completeopt = "menu,menuone,noinsert" },
      -- `:help ins-completion`
      mapping = cmp.mapping.preset.insert({
        ["<leader>n"] = cmp.mapping.select_next_item(),
        ["<leader>p"] = cmp.mapping.select_prev_item(),
        ["<cr>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
    })
  end,
}
