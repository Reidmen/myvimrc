--[[ If you experience any errors run `:checkhealth` --]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative number
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.mouse = "a" -- enable mouse
vim.opt.showmode = false -- don't shown mode, already in status line
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim
vim.opt.breakindent = true
vim.opt.undofile = false
vim.opt.ignorecase = true -- ignore case-sensitive unless \C or capital letters
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300 -- decrease mapped sequence wait
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10 -- Minimal number of lines to keep above and below
vim.opt.termguicolors = true -- true colors

-- [[ Basic Keymaps ]] See `:help vim.keymap.set()`
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
-- NOTE: See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<leader>h", "<C-w><C-h>", { desc = "Focus to the left window" })
vim.keymap.set("n", "<leader>l", "<C-w><C-l>", { desc = "Focus to the right window" })
vim.keymap.set("n", "<leader>j", "<C-w><C-j>", { desc = "Focus to the lower window" })
vim.keymap.set("n", "<leader>k", "<C-w><C-k>", { desc = "Focus to the upper window" })

-- Keybinds for managing splits and tabs
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "vv", ":vsplit<Return>", opts)
vim.keymap.set("n", "hs", ":split<Return>", opts)
vim.keymap.set("n", "te", ":tabedit<Return>", opts)
vim.keymap.set("n", "tn", ":tabnext<Return>", opts)
vim.keymap.set("n", "tp", ":tabprev<Return>", opts)

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
-- [[ Configure and install plugins ]]
require("lazy").setup({
  {
    -- See colorschemes already installed, use `:Telescope colorscheme`.
    -- 'folke/tokyonight.nvim',
    "navarasu/onedark.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.colorscheme("onedark")
      vim.cmd.hi("Comment gui=none")
    end,
    config = function()
      require("onedark").setup({ style = "darker" })
    end,
  },
  -- Highlight, edit, and navigate code
  {
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
  },
  "tpope/vim-sleuth",
  { "numToStr/Comment.nvim", opts = {} },
  { "nvim-tree/nvim-tree.lua", opts = {} },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  { -- Fuzzy Finder (files, lsp, etc)
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
  },
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "L3M0N4D3/LuaSnip",
    },
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        -- `:help ins-completion`
        mapping = cmp.mapping.preset.insert({
          ["<leader>n"] = cmp.mapping.select_next_item(),
          ["<leader>p"] = cmp.mapping.select_prev_item(),
          ["<cr>"] = cmp.mapping.confirm({ select = true }),
          -- ["<C-Space>"] = cmp.mapping.complete({}),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        },
      })
    end,
  },
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- NOTE: details about lsp and treesitter, see `:help lsp-vs-treesitter`
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("init-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
        clangd = {},
        pyright = {},
        -- ruff_lsp = {
        --   settings = { format = { args = { "--line-length", "79" } } },
        -- },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              completion = { callSnippet = "Replace" },
            },
          },
        },
      }

      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
        -- "black",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" }, -- isort, black
      },
    },
  },

  -- set of mini plugins
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
  -- Mojo language lsp and configuration
  {
    "czheo/mojo.vim",
    ft = { "mojo" },
    init = function()
      vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = { "*.🔥" },
        callback = function()
          if vim.bo.filetype ~= "mojo" then
            vim.bo.filetype = "mojo"
          end
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "mojo",
        callback = function()
          local modular = vim.env.MODULAR_HOME
          local lsp_cmd = modular .. "/pkg/packages.modular.com_mojo/bin/mojo-lsp-server"

          vim.bo.expandtab = true
          vim.bo.shiftwidth = 4
          vim.bo.softtabstop = 4

          vim.lsp.start({
            name = "mojo",
            cmd = { lsp_cmd },
          })
        end,
      })
    end,
  },
}, { ui = { icons = vim.g.have_nerd_font } })
