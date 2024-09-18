return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			view = {
				centralize_selection = false,
				cursorline = true,
				debounce_delay = 15,
				side = "left",
			}
		}
		vim.keymap.set("n", "<leader>ft", "<cmd>lua vim.cmd.NvimTreeToggle()<cr>")
		vim.keymap.set("n", "<F5>", "<cmd>lua vim.cmd.NvimTreeRefresh()<cr>")
	end
}
