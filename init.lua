-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

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
vim.api.nvim_set_hl(0, 'Normal', { bg = None, fg = None })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = None, fg = None })
---@diagnostic enable
-- vim: ts=2 sts=2 sw=2 et
