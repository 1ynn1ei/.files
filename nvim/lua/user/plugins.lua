
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"             -- lua api extensions
  use "nvim-lua/plenary.nvim"           -- ''
  use "kyazdani42/nvim-web-devicons"    -- icon support
  use "lewis6991/gitsigns.nvim"         -- ''
  use "MunifTanjim/nui.nvim"            -- Nvim gui helper
  use "neovim/nvim-lspconfig"           -- lsp configs
  use "nvim-lua/lsp_extensions.nvim"    -- extensions to LSP
  use "hrsh7th/nvim-cmp"                -- autocomplete
  use "hrsh7th/cmp-nvim-lsp"            -- lsp autocomplete
  use "hrsh7th/cmp-vsnip"               -- snippet completions
  use "hrsh7th/vim-vsnip"               -- ''
  use "hrsh7th/cmp-path"                -- path completion
  use "hrsh7th/cmp-buffer"              -- ''
  use "sainnhe/everforest"              -- colorscheme
  use "nvim-treesitter/nvim-treesitter" -- syntax highlighting
  use "nvim-telescope/telescope.nvim"   -- fuzzy find
  use "feline-nvim/feline.nvim"         -- status line
  use "nvim-neo-tree/neo-tree.nvim"     -- file tree
  use "dense-analysis/ale"              -- linter
  use { "numToStr/Comment.nvim",        -- commenter
    config = function()
      require('Comment').setup()
    end
  }
  use "glepnir/dashboard-nvim"          -- dashboard
  -- TODO: floatterm
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
