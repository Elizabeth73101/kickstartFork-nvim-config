-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Group for any autocommands that handle highlighting text on certain actions
vim.api.nvim_create_augroup('highlight-on-operations', { clear = false })
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = 'highlight-on-operations',
  callback = function()
    vim.hl.on_yank {
      higroup = 'Cursor',
    }
  end,
})

-- vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
--   desc = 'Open all folded text when loading a file',
--   group = vim.api.nvim_create_augroup('open-folded-on-read', { clear = true }),
--   callback = function()
--     vim.cmd 'normal zR'
--   end,
-- })
