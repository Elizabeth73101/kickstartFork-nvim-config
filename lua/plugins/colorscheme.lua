-- Put the name of the colorscheme here if it is already installed, otherwise follow
-- the more complicates lazy.nvim setup bellow
vim.cmd.colorscheme 'habamax'
return {}
--[[return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      styles = {
        comments = { italic = false }, -- Disable italics in comments
      },
    }

    -- Load the colorscheme here.
    vim.cmd.colorscheme 'tokyonight'
  end,
}]]
