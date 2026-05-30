local lsp_plugins_spec = {
	'neovim/nvim-lspconfig',
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "mason-org/mason.nvim",},
		{ 'mason-org/mason-lspconfig.nvim' },
		{ 'hrsh7th/nvim-cmp' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/cmp-nvim-lsp' },
	},
	config = function()
		-- note: diagnostics are not exclusive to lsp servers
		-- so these can be global keybindings
		vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
		--
		-- setup keybindings for lsp after attached to buffer
		vim.api.nvim_create_autocmd('LspAttach',
			{
				desc = 'LSP actions',
				callback = function(event)
					local buf = event.buf

					-- these will be buffer-local keybindings
					-- because they only work if you have an active language server

					--vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buf, desc = 'vim.lsp.definition' })
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = buf, desc = 'vim.lsp.declaration' })
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
						{ buffer = buf, desc = 'vim.lsp.implementation' })
					vim.keymap.set('n', 'go', vim.lsp.buf.type_definition,
						{ buffer = buf, desc = 'vim.lsp.type_definition' })
					--vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
					--vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
					--vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)	
					vim.keymap.set({ 'n', 'x' }, '<F3>', function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = buf, desc = 'vim.lsp.buf.format' })
					--
					vim.keymap.set({ 'n', 'x' }, '<F4>', vim.lsp.buf.code_action,
						{ buffer = buf, desc = 'vim.lsp.buf.code_action' })
					--vim.keymap.set("i", "<C-h>", '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				end
			}
		)

		-- mason setup
		local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
		require('mason').setup({})
		require('mason-lspconfig').setup({})


		-- cmp setup
		local cmp = require('cmp')
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_format = function(opts)
			opts = opts or {}
			local maxwidth = opts.max_width or false

			return {
				fields = { 'abbr', 'menu', 'kind' },
				format = function(entry, item)
					local n = entry.source.name
					if n == 'nvim_lsp' then
						item.menu = '[LSP]'
					elseif n == 'nvim_lua' then
						item.menu = '[nvim]'
					else
						item.menu = string.format('[%s]', n)
					end

					if maxwidth and #item.abbr > maxwidth then
						local last = item.kind == 'Snippet' and '~' or ''
						item.abbr = string.format(
							'%s %s',
							string.sub(item.abbr, 1, maxwidth),
							last
						)
					end

					return item
				end,
			}
		end
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				end,
			},
			sources = {
				{ name = 'path' },
				{ name = 'nvim_lsp' },
				{ name = 'buffer',  keyword_length = 3 },
			},
			formatting = cmp_format(),
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm { select = false },
				['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				['<Tab>'] = nil,
				['<S-Tab>'] = nil,
			})
		})
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
					{ name = 'path' }
				},
				{
					{ name = 'cmdline' }
				})
		})



		-- manaul LSP setup
		--vim.lsp.config('bashls')
		vim.lsp.enable('bashls')
		--vim.lsp.config('pyright', {
		--	capabilities = lsp_capabilities,
		--	settings = {
		--		python = {
		--			analysis = {
		--				useLibraryCodeForTypes = true,
		--				diagnosticSeverityOverrides = {
		--					reportUnusedVariable = "warning",
		--				},
		--				typeCheckingMode = "off", -- Set type-checking mode to off
		--				diagnosticMode = "off", -- Disable diagnostics entirely
		--			},
		--		},
		--	},
		--})
		--vim.lsp.enable('pyright')
		--vim.lsp.config('taplo', {
		--	capabilities = lsp_capabilities
		--})
		--vim.lsp.enable('taplo')
		--require('lspconfig').openscad_lsp.setup {}
		--require('lspconfig').zls.setup {}
		--require('lspconfig').clangd.setup {}

		-- lua
		vim.lsp.config('lua_ls', {
			capabilities = lsp_capabilities,
			settings = {
				Lua = {
					runtime = {
						version = 'LuaJIT'
					},
					diagnostics = {
						globals = { 'vim', 'require' },
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
						}
					}
				}
			}
		})
		vim.lsp.enable('lua_ls')
		--

		vim.lsp.config('dartls', {
			capabilities = lsp_capabilities,
			settings = {
				dart = {
					completeFunctionCalls = true,
					showTodos = true,
				},
			}
		}
		)
		vim.lsp.enable('dartls')
		--	
		vim.lsp.config('clangd', {
			capabilities = lsp_capabilities
		}
		)
		vim.lsp.enable('clangd')
		vim.diagnostic.config({
			virtual_text = true
		})
	end
}
return lsp_plugins_spec
