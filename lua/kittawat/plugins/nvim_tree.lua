return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {}
		vim.keymap.set("n", "<leader>ft" , vim.cmd.NvimTreeToggle)
		vim.keymap.set("n", "<leader>pv" , vim.cmd.NvimTreeOpen)
	end
}
