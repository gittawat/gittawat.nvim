local trouble_spec = {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.keymap.set('n','<leader>tt',"<cmd>TroubleToggle workspace_diagnostics<cr>")
		vim.keymap.set('n', '<leader>tn', '<cmd>lua require("trouble").next({skip_groups = true, jump = true})<cr>')
		vim.keymap.set('n', '<leader>tp', '<cmd>lua require("trouble").previous({skip_groups = true, jump = true})<cr>')
	end
}

return trouble_spec
