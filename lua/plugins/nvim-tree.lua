return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  -- see nvim-tree-config-default for default config
  config = function()
    ---@type nvim_tree.config
    local opts = {
      -- here wo do stuff we wanna run when nvim-tree attaches
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        -- default bindings -- REQUIRED
        api.map.on_attach.default(bufnr)

        -- custom bindings
        vim.keymap.set('n', '\\', api.tree.toggle)

        -- theme settings
        vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = None })
        vim.api.nvim_set_hl(0, 'NvimTreeFolderArrowClosed', { fg = None })
        vim.api.nvim_set_hl(0, 'NvimTreeFolderArrowOpen', { fg = None })
        vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = None })
      end,

      hijack_cursor = true,
      auto_reload_on_write = true,
      sort = {
        folders_first = true,
      },
      renderer = {
        icons = {
          git_placement = 'right_align',
          show = {
            hidden = true,
          },
          glyphs = {
            bookmark = 'b',
            modified = 'm',
            hidden = 'h',
            git = {
              unstaged = '~',
              staged = '.',
              unmerged = '^',
              renamed = '>',
              untracked = '?',
              deleted = '-',
              ignored = 'i',
            },
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
        icons = {
          hint = '?',
          info = 'i',
          warning = '!',
          error = 'X',
        },
      },
      modified = {
        enable = true,
        show_on_dirs = true,
      },
    }

    require('nvim-tree').setup(opts)
  end,
}
