return {
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = { { 'nvim-lua/plenary.nvim' } },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", {})
			vim.keymap.set('n', '<C-p>', "<cmd>lua require('telescope.builtin').git_files()<cr>", {})
			vim.keymap.set('n', '<leader>fg', function()
				builtin.grep_string({ search = vim.fn.input("grep > ") })
			end)
		end
	}

}
