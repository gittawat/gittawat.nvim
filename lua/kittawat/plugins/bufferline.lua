local bufferline_spec = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("bufferline").setup {
			options = {
				mode = 'buffer',
				diagnostics = "nvim_lsp",
				diagnostics_update_on_event = true,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						--text_align = "left" | "center" | "right"
						separator = true
					}
				}
			}
		}
	end
}
return bufferline_spec
