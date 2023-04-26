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
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'mbbill/undotree'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require('telescope').setup {
                defaults =  {
                    vimgrep_arguments = {
                        'rg',
                        '--hidden',
                    }
                }
            }
        end
    }
    use ({
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate"
    })
    use ('theprimeagen/harpoon')
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
    if packer_bootstrap then
        require('packer').sync()
    end
end)

