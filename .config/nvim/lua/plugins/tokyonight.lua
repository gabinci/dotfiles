return {
  {-- the colorscheme should be available when starting Neovim
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
          keywords = { italic = false },
          functions = {},
          variables = {},
        },
      }
      vim.cmd.colorscheme 'tokyonight-night' -- load colorscheme on startup
    end,
  },
}
