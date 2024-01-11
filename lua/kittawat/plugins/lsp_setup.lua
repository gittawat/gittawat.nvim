local lsp_plugins_spec = {
	{
		'neovim/nvim-lspconfig',
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim",          build = ":MasonUpdate" },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'L3MON4D3/LuaSnip' },
		},
		config = function()
			-- note: diagnostics are not exclusive to lsp servers
			-- so these can be global keybindings
			vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

			-- setup keybindings for lsp after attached to buffer
			vim.api.nvim_create_autocmd('LspAttach',
				{
					desc = 'LSP actions',
					callback = function(event)
						local opts = { buffer = event.buf }

						-- these will be buffer-local keybindings
						-- because they only work if you have an active language server

						vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
						vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
						vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
						vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
						vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
						vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
						vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
						vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
						vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
						vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

						if vim.lsp.buf.range_code_action then
							vim.keymap.set('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', opts)
						else
							vim.keymap.set('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
						end

						vim.keymap.set("i", "<C-h>", '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
					end
				}
			)

			-- mason setup
			local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
			local default_setup = function(server)
				require('lspconfig')[server].setup({
					capabilities = lsp_capabilities,
				})
			end

			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {},
				handlers = {
					default_setup,
					lua_ls = function()
						require('lspconfig').lua_ls.setup({
							capabilities = lsp_capabilities,
							settings = {
								Lua = {
									runtime = {
										version = 'LuaJIT'
									},
									diagnostics = {
										globals = { 'vim' },
									},
									workspace = {
										library = {
											vim.env.VIMRUNTIME,
										}
									}
								}
							}
						})
					end,
				},
			})


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
					{ name = 'nvim_lua' },
				},
				formmating = cmp_format(),
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


			require('lspconfig').bashls.setup {}
			require('lspconfig').pylsp.setup {
				settings = {
					pylsp = {
						plugins = {
							ruff = {
								enabled = true, -- Enable the plugin
							}
						}
					}
				}
			}
			require('lspconfig').openscad_lsp.setup {}
			require('lspconfig').zls.setup {}
			require('lspconfig').clangd.setup {}


			vim.diagnostic.config({
				virtual_text = true
			})
		end
	}

}

return lsp_plugins_spec
