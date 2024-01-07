vim.g.mapleader = " "
vim.keymap.set("n", "<leader>/", vim.cmd.nohlsearch)
vim.keymap.set("n", "<leader>c/",":let @/=''<Enter>")
-- Set h for up, j for down, k for left, and l for right
vim.api.nvim_set_keymap('n', 'j', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('n', 'h', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('n', 'l', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('v', 'j', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('v', 'k', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('v', 'h', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('v', 'l', '<Right>', { noremap = true })

