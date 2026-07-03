-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- use the better 24-bit colours
vim.o.termguicolors = true

-- [[ Setting options ]]
vim.o.number = true
vim.o.relativenumber = false
vim.o.mouse = 'a'
vim.o.confirm = false
vim.o.list = true
vim.opt.listchars = { tab = '> ', trail = '·', nbsp = '␣' }
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.breakindent = true
vim.o.undofile = true
vim.o.smarttab = true
vim.o.expandtab = true

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Enable folding by expression
vim.o.foldmethod = 'expr'
-- -- for some reason nvim_treesitter#foldexpr() doesnt work
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Disable all folds being closed on file open
vim.o.foldenable = false
-- Fixes some issues with the first time you fold something
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Basic Autocommands ]]
require 'autocommands'

-- [[ Configure and install plugins ]]
-- Install `lazy.nvim` plugin manager
require 'lazy-bootstrap'
require 'plugins'

-- Load colorscheme and make background transparent
vim.cmd.colorscheme 'min-dark'

---@diagnostic disable: undefined-global
vim.api.nvim_set_hl(0, 'Normal', { bg = None })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = None })
---@diagnostic enable
-- vim: ts=2 sts=2 sw=2 et
