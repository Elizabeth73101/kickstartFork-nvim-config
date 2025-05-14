return {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter',

  -- Loads the plugin on this keymap
  -- Useful for showing LSP keybinds
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },

  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 300,

    -- Dont show anything for these operators or modes until a second character is pressed (aka for textobjects)
    ---@param ctx { mode: string, operator: string }
    defer = function(ctx)
      local op_match = vim.list_contains({ 'y', 'd', 'c' }, ctx.operator)
      local mode_match = vim.list_contains({ 'V', 'C-V', 'v' }, ctx.mode)
      if mode_match or op_match then
        return true
      end
    end,

    icons = {
      mappings = false,
      keys = {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      -- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
