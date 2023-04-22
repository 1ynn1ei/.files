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
  integrations = {
    lualine = true
  }
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
  require('lualine').hide()
  require('true-zen').ataraxis()
  require('lualine').hide({ unhide = true })
  require('lualine').setup(lualine_config)
  vim.api.nvim_set_hl(0, "StatusLineNC", {})
  vim.api.nvim_set_hl(0, "NvimTreeStatusLineNC", {})
  vim.cmd[[
    SoftPencil
    MarkdownPreview
  ]]
end

vim.api.nvim_create_user_command('Raven', function(opts)
  raven_mode(opts)
end, { nargs = '*' })

