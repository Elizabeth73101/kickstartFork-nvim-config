return { -- Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    completion = {
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      -- Show only ghost text without menu, unless <c-space> is pressed to show the menu
      ghost_text = { enabled = true, show_with_menu = false },
      menu = { auto_show = false },
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        lua = {
          inherit_defaults = true,
          'lazydev',
        },
      },

      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Shows a signature help window while typing arguments for a function
    signature = { enabled = true },
  },
}
