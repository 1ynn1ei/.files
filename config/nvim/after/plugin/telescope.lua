require('telescope').setup {
    defaults =  {
        vimgrep_arguments = {
            'rg',
            '--hidden',
        }
    },
    pickers = {
      find_files = {
        theme = 'ivy'
      },
      treesitter = {
        theme = 'ivy'
      },
      buffers = {
        theme = 'ivy'
      }
    }
}
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fp', builtin.grep_string, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
