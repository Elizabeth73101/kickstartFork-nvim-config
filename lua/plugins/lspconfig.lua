return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Mason must be loaded before its dependents so we need to set it up here.
    -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    --    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('config-lsp-attach', { clear = true }),

      -- Helper function for more easily defining LSP keybinds
      -- Comes from the default kickstarter script
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        --[[ Redefining the default binds to have a more useful description ]]
        --  Most Language Servers support renaming across files, etc.
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        -- Find references for the word under your cursor.
        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        -- Jump to the definition of the word under your cursor.
        --  To jump back, press <C-t>.
        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        -- WARN: This is not Goto Definition, this is Goto Declaration.
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
        -- Jump to the type of the word under your cursor.
        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- Highlight references under cursor, remove when cursor is moved
        --[[
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('config-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('config-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'config-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
        ]]
        -- Toggle inlay hints
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Diagnostic Config
    vim.diagnostic.config {
      severity_sort = true,
      float = { source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      jump = { float = true }, -- Seemingly broken?
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    -- [[ Config pertaining to things lspconfig uses rather than lspconfig itself ]]
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    -- Pull in configuration for servers
    local servers = require 'lsp'
    for srv_name, srv_conf in pairs(servers) do
      srv_conf.capabilities = vim.tbl_deep_extend('force', {}, capabilities, srv_conf.capabilities or {})
      vim.lsp.config(srv_name, srv_conf)
    end

    -- mason has to be set up above under 'dependencies'
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = false,
      automatic_enable = true,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          vim.lsp.config(server_name, server)
        end,
      },
    }
  end,
}
