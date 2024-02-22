require('my.packer')
require('my.options')
require('my.keymaps')

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Autocommand that reloads neovim whenever you save the plugins.lua file
autocmd('BufWritePost', {
	pattern = { "packer.lua" },
	callback = function ()
		require('packer').sync()
	end,
})

