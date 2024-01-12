return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>git", function()
			vim.cmd.Git()
			local key_sequence = vim.api.nvim_replace_termcodes("<C-W>T", true, true, true)
			vim.api.nvim_feedkeys(key_sequence, "n", true)
		end);
	end
}
