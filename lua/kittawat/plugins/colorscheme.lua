return {
	{
		'echasnovski/mini.base16',
		version = false,
		config = function()
			if vim.fn.has("termguicolors") then
				vim.opt.termguicolors = true
			end
			vim.cmd("set background=light")
			vim.cmd("set background=light")
			vim.cmd("colorscheme minicyan")
			vim.cmd("colorscheme minicyan")
		end
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			--			vim.cmd("colorscheme kanagawa")
		end
	},
	{
		"EdenEast/nightfox.nvim",
	}
}
