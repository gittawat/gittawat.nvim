local lsp_z = require("lsp-zero")
--lsp_z.preset("recommended")
--lsp_z.nvim_workspace()

--lsp_z.set_preferences({
--    suggest_lsp_servers = false,
--    sign_icons = {
--        error = 'E',
--        warn = 'W',
--        hint = 'H',
--        info = 'I'
--    }
--})
lsp_z.set_sign_icons({
	error = 'E',
	warn = 'W',
	hint = 'H',
	info = 'I',
})

lsp_z.nvim_lua_ls()

lsp_z.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	lsp_z.default_keymaps({
		buffer = bufnr,
		preserve_mappings = false
	})
	--vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	--vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		lsp_z.default_setup,
		lua_ls = function()
			local lua_opts = lsp_z.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,
	}
})

lsp_z.setup()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
	},
	formmating = lsp_z.cmp_format(),
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

--local cmp_mappings = lsp_z.defaults.cmp_mappings({
--  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--  ["<C-Space>"] = cmp.mapping.complete(),
--})

--lsp_z.setup_nvim_cmp({
--  mapping = cmp_mappings
--})

require('lspconfig').bashls.setup {}
require('lspconfig').pylsp.setup {
	settings = {
		pylsp = {
			plugins = {
				ruff = {
					enabled = true,        -- Enable the plugin
					--executable = "<path-to-ruff-bin>", -- Custom path to ruff
					--path = "<path_to_custom_ruff_toml>", -- Custom config for ruff to use
					extendSelect = { "I" }, -- Rules that are additionally used by ruff
					extendIgnore = { "C90" }, -- Rules that are additionally ignored by ruff
					format = { "I" },      -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
					severities = { ["D212"] = "I" }, -- Optional table of rules where a custom severity is desired
					unsafeFixes = false,   -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

					-- Rules that are ignored when a pyproject.toml or ruff.toml is present:
					lineLength = 88,                   -- Line length to pass to ruff checking and formatting
					exclude = { "__about__.py" },      -- Files to be excluded by ruff checking
					select = { "F" },                  -- Rules to be enabled by ruff
					ignore = { "D210" },               -- Rules to be ignored by ruff
					perFileIgnores = { ["__init__.py"] = "CPY001" }, -- Rules that should be ignored for specific files
					preview = false,                   -- Whether to enable the preview style linting and formatting.
					targetVersion = "py310",           -- The minimum python version to target (applies for both linting and formatting).
				},
			}
		}
	}
}
require('lspconfig').openscad_lsp.setup {}
require('lspconfig').zls.setup {}
require('lspconfig').clangd.setup {}

--local lua_opts = lsp_z.nvim_lua_ls()
--require('lspconfig').lua_ls.setup(lua_opts)

vim.diagnostic.config({
	virtual_text = true
})
