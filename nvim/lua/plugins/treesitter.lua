return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter = require('nvim-treesitter')

      -- install() is asynchronous and becomes a no-op for parsers that are
      -- already present. HEEx is included for Phoenix templates.
      treesitter.install({ 'elixir', 'heex' })

      -- nvim-treesitter's current main branch supplies parsers and queries;
      -- Neovim itself owns and starts highlighting.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user.treesitter', { clear = true }),
        pattern = { 'elixir', 'heex' },
        callback = function(event)
          -- On a brand-new setup the asynchronous install can still be
          -- finishing when the first buffer opens; reopening then starts it.
          pcall(vim.treesitter.start, event.buf)
        end,
      })
    end,
  },
}
