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
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local lazy_options = {
  cache = {
    enabled = true,
  },
  reset_packpath = true,
  rtp = {
    reset = true,
    disabled_plugins = {
      "gzip",
      "matchit",
      "matchparen",
      "netrwPlugin",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    },
  },
}

require("lazy").setup({
  require("theme"),
  require("treesitter"),
  { "j-hui/fidget.nvim", opts = {} },
  "tpope/vim-sleuth",
  { "numToStr/Comment.nvim", opts = {} },
  { "nvim-tree/nvim-tree.lua", opts = {} },
  require("signs"),
  { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font, lazy = true },
  require("finder"),
  require("completion"),
  require("lsp"),
  require("formatter"),
  require("mini-plugins"),
  require("mojo-lang"),
}, lazy_options)
