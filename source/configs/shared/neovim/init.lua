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
-- plugins
vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}
---- nvim-lspconfig
if vim.fn.executable( "clangd" ) == 1 then
  vim.lsp.config.clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp" },
  }
  vim.lsp.enable("clangd", {})
end
