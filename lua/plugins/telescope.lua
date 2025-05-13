return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    -- required dependency for telescope
    'nvim-lua/plenary.nvim',

    -- Fuzzy finding with better performance
    {
      'nvim-telescope/telescope-fzf-native.nvim',

      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    -- Sets vim.ui.select to telescope. That means neovim core stuff can fill the telescope picker.
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local bordchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
    local height = { padding = 0.2 }
    local width = 0.5
    require('telescope').setup {
      defaults = {
        layout_strategy = 'flex',
        layout_config = {
          anchor = 'C',
          height = height,
          width = width,
          horizontal = { preview_width = 0 },
          vertical = { preview_height = 0 },
        },

        prompt_prefix = ' ',
        selection_caret = ' ',
        entry_prefix = ' ',
        multi_icon = ' ',

        borderchars = bordchars,

        results_title = '',
        prompt_title = '',
      },

      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    }
    -- Enable Telescope extensions if they are installed
    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'ui-select'

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = '[S]earch [T]reesitter symbols' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        layout_config = {
          height = height,
          width = width,
        },
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
