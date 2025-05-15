return {
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  lua_ls = require 'lsp.lua_ls',
  clangd = require 'lsp.clangd',
  rust_analyzer = require 'lsp.rust_analyzer',
}
