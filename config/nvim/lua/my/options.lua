vim.opt.clipboard = "unnamedplus"  	-- disable * and + register
vim.opt.cmdheight = 2
vim.opt.fileencoding = "utf-8"
vim.opt.completeopt={"menuone", "noinsert" ,"noselect"}
vim.opt.shortmess:append "c"
vim.opt.termguicolors = true
					-- ensure consistent split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.undofile = true 		-- persists undo, very useful
vim.opt.expandtab = true		-- always use spaces, convert tab
vim.opt.updatetime = 300
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
					-- better jumping around
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.signcolumn = "yes"
					-- wrap specific 
vim.opt.wrap = false
vim.opt.sidescrolloff = 8

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set colorcolumn=100]]
