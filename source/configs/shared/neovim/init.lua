-- basic options
---- numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.number = true
---- tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 8
---- autocomplete
vim.o.autocomplete = true
vim.o.completeopt = 'menu,menuone,noselect'
---- colorscheme
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.cmd( "colorscheme default" )
-- keymap
---- helper to trigger native keys
local function feed_keys( key_string )
  local keys = vim.api.nvim_replace_termcodes( key_string, true, true, true )
  vim.api.nvim_feedkeys( keys, 'n', false )
end
---- insert mode: Control-Space to trigger LSP autocomplete
vim.keymap.set( 'i', '<C-Space>', function( )
  feed_keys( '<C-x><C-o>' )
end, { desc = 'Trigger LSP Autocomplete' } )
---- normal mode: Space to trigger append mode with LSP autocomplete
vim.keymap.set( 'n', '<Space>', function( )
  feed_keys( 'a<C-x><C-o>' )
end, { desc = 'Enter Insert Mode and Trigger LSP Autocomplete' } )
-- enable autocomplete for LSP
vim.api.nvim_create_autocmd( 'LspAttach', {
  callback = function( ev )
    local client = assert( vim.lsp.get_client_by_id( ev.data.client_id ) )
    if client:supports_method( 'textDocument/completion' ) then
      vim.lsp.completion.enable( true, client.id, ev.buf, { autotrigger = true } )
    end
  end,
} )
-- plugins
---- delete command example
---- vim.pack.del( { 'nvim-lspconfig' } )
---- add command example
vim.pack.add( { 'https://github.com/neovim/nvim-lspconfig' } )
-- nvim-lspconfig related
---- C/C++
if vim.fn.executable( "clangd" ) == 1 then
  vim.lsp.config.clangd = {
    cmd = { "clangd", "--header-insertion=never" },
    filetypes = { "c", "cpp" },
  }
  vim.lsp.enable( "clangd", { } )
end
-- highlight
local function darkness( )
  vim.cmd( 'syntax on' )
  -- color groups (last wins)
  local Colors = {
    Grey    = { color = "#808080", groups = { "Comment", "@lsp.type.namespace.cpp" } },
    White   = { color = "#C0C0C0", groups = { "Constant", "String", "Type", "@punctuation" } },
    Blue    = { color = "#8080C0", groups = { "Identifier" } },
    Yellow  = { color = "#C0C080", groups = { "Function", "Special" } },
    Green   = { color = "#80C080", groups = { "@property" } },
    Magenta = { color = "#C080C0", groups = { "PreProc" } },
    Red     = { color = "#C08080", groups = { "Statement" } },
    Cyan    = { color = "#80C0C0", groups = { "@variable" } },
  }
  -- style groups
  local Styles = {
    Bold = { "Statement", "@punctuation" },
    Ital = { "Comment", "String" },
  }
  local hl = vim.api.nvim_set_hl
  -- editor
  hl( 0, "Normal", { bg = "#202020", fg = '#C0C0C0' } )
  -- tokens
  -- build lookup sets for styles
  local bold_set = { }
  local ital_set = { }
  for _, g in ipairs( Styles.Bold or { } ) do bold_set[g] = true end
  for _, g in ipairs( Styles.Ital or { } ) do ital_set[g] = true end
  -- populate colors
  for _, spec in pairs( Colors ) do
    local color = spec.color
    for _, group in ipairs( spec.groups or { } ) do
      local opts = { }
      if color then opts.fg = color end
      if bold_set[group] then opts.bold = true end
      if ital_set[group] then opts.italic = true end
      hl(0, group, opts)
    end -- for Groups
  end -- for Colors
end -- function darkness
---- invoke highlighting overrides
darkness( )
