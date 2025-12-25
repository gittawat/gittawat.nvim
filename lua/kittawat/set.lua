vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python_recommended_style = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.clipboard = "unnamed,unnamedplus"
vim.g.clipboard = "wl-copy"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

--vim.api.nvim_command("autocmd FileType python setlocal softtabstop=0 noexpandtab")


vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

--vim.opt.hlsearch = false
--vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
--vim.opt.colorcolumn = "80"
