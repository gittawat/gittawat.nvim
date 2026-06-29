--https://github.com/j-morano/buffer_manager.nvim.git
return {
	"j-morano/buffer_manager.nvim",
	dependencies = { { 'nvim-lua/plenary.nvim' } },
	config = function()
		require("buffer_manager").setup({
			select_menu_item_commands = {
				v = { key = "<C-v>", command = "vsplit" },
				h = { key = "<C-h>", command = "split" },
			},
			focus_alternate_buffer = false,
			short_file_names = false,
			with_flags = true,
		})

		local ui = require("buffer_manager.ui")

		vim.keymap.set("n", "<leader><tab>", ui.toggle_quick_menu, { desc = "Toggle Buffer Manager Menu" })
		vim.keymap.set("n", "[b", ui.nav_prev, { desc = "Go to Previous Buffer" })
		vim.keymap.set("n", "]b", ui.nav_next, { desc = "Go to Next Buffer" })
	end,
}
