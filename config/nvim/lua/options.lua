-- don't give the intro message when starting nvim
vim.opt.shortmess:append("I")
-- use system clipboard
vim.opt.clipboard = "unnamedplus"
-- enable 24-bit colour
vim.opt.termguicolors = true
-- auto reload if changed
vim.opt.autoread = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
-- vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
vim.opt.jumpoptions = "stack"

-- Tab
vim.opt.tabstop = 2 -- number of visual spaces per TAB
vim.opt.softtabstop = 2 -- number of spacesin tab when editing
vim.opt.shiftwidth = 0
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

vim.opt.number = true
vim.opt.cursorline = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
-- vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
