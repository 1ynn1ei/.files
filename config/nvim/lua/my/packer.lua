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
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })
    
    use {"lewis6991/gitsigns.nvim",  
    config = function()
        require('gitsigns').setup()
    end
}
end)

