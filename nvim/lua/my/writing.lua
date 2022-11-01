local keymap = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true, }

require('true-zen').setup {
  modes = {
    ataraxis = {
      minimum_writing_area = {
        width = 80
      },
      padding = {
        top = -10
      }
    }
  },
}

local function word_count()
  return tostring(vim.fn.wordcount().words)
end

local function raven_mode()
  vim.opt_local.spell=true
  vim.opt_local.spelllang='en_us'
  local lualine_config = require('lualine').get_config()
  lualine_config.sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {'location'},
    lualine_y = {'progress'},
    lualine_z = {word_count},
  }
  lualine_config.tabline = {}
  require('lualine').setup(lualine_config)
  require('true-zen').ataraxis()
  vim.api.nvim_set_hl(0, "StatusLineNC", {})
  vim.api.nvim_set_hl(0, "NvimTreeStatusLineNC", {})
  vim.cmd[[
    SoftPencil
    MarkdownPreview
  ]]

  -- vim.cmd[[
  --      setlocal spell spelllang=en_us
  --      Goyo 66
  --      SoftPencil
  --      echo "Prose Mode On"
  -- ]]
end

vim.api.nvim_create_user_command('Raven', function(opts)
  raven_mode(opts)
end, { nargs = '*' })

