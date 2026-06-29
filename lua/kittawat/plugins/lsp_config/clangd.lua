return function(lsp_capabilities)
	return {
		capabilities = lsp_capabilities,
		cmd = { "clangd",
			--"--query-driver=/usr/bin/arm-none-eabi-g*,/usr/bin/gcc,/usr/bin/g++,/usr/bin/clang*"
			"--query-driver=**",
			"--background-index",
			"--clang-tidy"
		},
	}
end
