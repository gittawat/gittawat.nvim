local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	'rebelot/kanagawa.nvim',
	{
	"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
	},
	{
	'nvim-telescope/telescope.nvim', tag = '0.1.1',dependencies = { {'nvim-lua/plenary.nvim'} }
	},
	"mbbill/undotree",
	"tpope/vim-fugitive",
}
local opts = {}

require("lazy").setup(plugins, opts)
