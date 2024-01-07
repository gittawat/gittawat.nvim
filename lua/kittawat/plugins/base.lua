return {
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
    {
        'nvim-telescope/telescope.nvim', version = '*',dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({
            })
        end,
    },
    "mbbill/undotree",
    "tpope/vim-fugitive",
	{
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
}
