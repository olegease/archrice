-- basic options
vim.cmd( 'syntax on' )
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
---- helper to trigger native keys
local function feed_keys(key_string)
  local keys = vim.api.nvim_replace_termcodes(key_string, true, true, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end
---- insert mode: Control-Space
vim.keymap.set('i', '<C-Space>', function()
  feed_keys('<C-x><C-o>')
end, { desc = 'Trigger LSP Autocomplete' })
---- normal mode: Space to enter append mode
vim.keymap.set('n', '<Space>', function()
  feed_keys('a<C-x><C-o>')
end, { desc = 'Enter Insert Mode and Trigger LSP Autocomplete' })
---- attachment
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = assert( vim.lsp.get_client_by_id( ev.data.client_id ) )
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
-- plugins
---- nvim-lspconfig
if vim.fn.executable( "clangd" ) == 1 then
  vim.lsp.config.clangd = {
    cmd = { "clangd", "--header-insertion=never" },
    filetypes = { "c", "cpp" },
  }
  vim.lsp.enable( "clangd", { } )
end
