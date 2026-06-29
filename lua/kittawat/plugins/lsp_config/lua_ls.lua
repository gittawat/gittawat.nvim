return function(lsp_capabilities)
	return {
		capabilities = lsp_capabilities,
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					-- Tells the language server that 'vim' is a safe global variable
					globals = { 'vim', 'require' },
				},
				workspace = {
					-- Makes the server aware of Neovim runtime files
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			},
		},
	}
end
