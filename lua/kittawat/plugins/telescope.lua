return {
	{
		'nvim-telescope/telescope.nvim',
		tag = 'v0.1.9',
		dependencies = { { 'nvim-lua/plenary.nvim' } },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", {})
			vim.keymap.set('n', '<C-p>', "<cmd>lua require('telescope.builtin').git_files()<cr>", {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		end
	}
}
