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
-- telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files theme=dropdown<cr>", options)
keymap("n", "<leader>p", "<cmd>Telescope live_grep theme=dropdown<cr>", options)
-- lsp
keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", options)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", options)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", options)
keymap("n", "g[", "<cmd>lua vim.diagnosticc.goto_prev()<cr>", options)
keymap("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<cr>", options)
-- floaterm
keymap("n", "<leader>t", "<cmd>Fterm<cr>", options)