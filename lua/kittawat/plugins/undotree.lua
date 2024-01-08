return {
	"mbbill/undotree",
	config = function()
		vim.g.undotree_WindowLayout = 4
		vim.keymap.set('n', '<leader>u','<cmd>UndotreeToggle<cr>')
	end
}
