vim.g.mapleader = " "
vim.keymap.set("n", "<leader>/", vim.cmd.nohlsearch)
vim.keymap.set("n", "<leader>c/", ":let @/=''<Enter>")
vim.cmd("map <leader>e <CR>")


-- Set h for up, j for down, k for left, and l for right
vim.keymap.set({ "n", "v" }, 'k', 'j', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, 'j', 'k', { noremap = true, silent = true })
vim.keymap.set("n","<tab><right>", ":bnext<Enter>")
vim.keymap.set("n","<tab><left>", ":bprevious<Enter>")
-- <C-space> toggle between normal and insert mode
-- vim.keymap.set("n", '<C-space>', 'i', { noremap = true, silent = true })
-- vim.keymap.set("i", '<C-space>', '<ESC>', { noremap = true, silent = true })
