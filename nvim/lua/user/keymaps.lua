local keymap = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true, }

keymap("", "<Space>", "<Nop>", options) -- remove existing space map
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- window nav
keymap("n", "<C-h>", "<C-w-h>", options)
keymap("n", "<C-j>", "<C-w-j>", options)
keymap("n", "<C-k>", "<C-w-k>", options)
keymap("n", "<C-l>", "<C-w-l>", options)
-- indent
keymap("v", "<", "<gv", options)
keymap("v", ">", ">gv", options)
--  move text
keymap("v", "<A-j>", ":m .+1<CR>==", options)
keymap("v", "<A-k>", ":m .-2<CR>==", options)

