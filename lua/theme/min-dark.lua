return {
  'wesleimp/min-theme.nvim',
  name = 'min-dark',
  lazy = false,
  priority = 1000, -- load this before other plugins
  config = function()
    vim.cmd.colorscheme 'min-dark'
  end,
}
