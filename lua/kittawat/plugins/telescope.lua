return {
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = { { 'nvim-lua/plenary.nvim' } },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<C-p>', builtin.git_files, {})
			vim.keymap.set('n', '<leader>fg', function()
				builtin.grep_string({ search = vim.fn.input("grep > ") })
			end)
		end
	}

}
