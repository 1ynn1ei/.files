
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
  use {"lewis6991/gitsigns.nvim",       -- ''
    config = function()
      require('gitsigns').setup()
    end
  }
  use "MunifTanjim/nui.nvim"            -- Nvim gui helper
  use "neovim/nvim-lspconfig"           -- lsp configs
  use "nvim-lua/lsp_extensions.nvim"    -- extensions to LSP
  use "hrsh7th/nvim-cmp"                -- autocomplete
  use "hrsh7th/cmp-nvim-lsp"            -- lsp autocomplete
  use "hrsh7th/cmp-vsnip"               -- snippet completions
  use "hrsh7th/vim-vsnip"               -- ''
  use "hrsh7th/cmp-path"                -- path completion
  use "hrsh7th/cmp-buffer"              -- ''
  use "bluz71/vim-moonfly-colors"       -- colorscheme
  use "Mofiqul/dracula.nvim"
  use "nvim-treesitter/nvim-treesitter" -- syntax highlighting
  use "nvim-telescope/telescope.nvim"   -- fuzzy find
  use "nvim-lualine/lualine.nvim"       -- status line
  use "dense-analysis/ale"              -- TODO: linter
  use { "numToStr/Comment.nvim",        -- commenter
    config = function()
      require('Comment').setup()
    end
  }
  use "glepnir/dashboard-nvim"          -- dashboard
  use "doums/floaterm.nvim"             -- terminal
  -- writing
  use { "folke/twilight.nvim",          -- highlight selected code
    config = function()
      require("twilight").setup{}
    end
  }
  use { "folke/zen-mode.nvim",          -- center text
    config = function()
      require("zen-mode").setup{}
    end
  }
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
