local fn = vim.fn


-- Automatically install packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
      vim.cmd [[packadd packer.nvim]]
      return true
    end
    return false
  end

local packer_bootstrap = ensure_packer()

require('packer').init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

return require('packer').startup(function(use)
    use 'norcalli/nvim-colorizer.lua'
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'frabjous/knap'
    use 'mbbill/undotree'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        requires = { {'nvim-lua/plenary.nvim'} },
    }
    use ({
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate"
    })
    use {
      'theprimeagen/harpoon',
      branch = 'harpoon2',
      requires = { {'nvim-lua/plenary.nvim'} },
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},             -- Required
          {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
              pcall(vim.cmd, 'MasonUpdate')
            end,
          }, 
          {'williamboman/mason-lspconfig.nvim'}, -- Optional
      
          -- Autocompletion
          {'hrsh7th/nvim-cmp'},     -- Required
          {'hrsh7th/cmp-nvim-lsp'}, -- Required
          {'L3MON4D3/LuaSnip'},     -- Required
        }
      }
    use ({
        'rose-pine/neovim',
        as = 'rose-pine',
    })
    use 'nvim-lualine/lualine.nvim'
    use 'numToStr/Comment.nvim'
    use 'ThePrimeagen/refactoring.nvim'
    use 'lewis6991/gitsigns.nvim'
    -- use 'lervag/vimtex'
    use {
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = { 
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      }
  }
    if packer_bootstrap then
        require('packer').sync()
    end
end)

