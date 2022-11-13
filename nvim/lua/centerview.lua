local function half_round(val)
  return val % 2 > 0 and (val - 1) / 2 or val / 2
end

local function pad_with_buffer(opts, new_command, move_command)
  vim.cmd(new_command)
  local window_id = vim.api.nvim_get_current_win()
  if opts.hors ~= nil then
    vim.api.nvim_win_set_width(0, opts.hors)
  else
    vim.api.nvim_win_set_height(0, opts.vert)
  end
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.modifiable = false
  vim.bo.buflisted = false
  vim.bo.swapfile = false
  vim.wo.cursorline = false
  vim.wo.cursorcolumn = false
  vim.wo.relativenumber = false
  vim.wo.list = false
  vim.cmd(move_command) --move us back into main window
  return window_id
end


local function calculate_padding(opts)
  local padding = {}
  local dimensions = vim.api.nvim_list_uis()[1]
  padding.hors = half_round(dimensions.width - opts.minimum_width)
  padding.vert = half_round(dimensions.height - opts.minimum_height)
  return padding
end

local function centerview()
  local padding = calculate_padding({ minimum_width = 66, minimum_height = 44 })
  pad_with_buffer({ hors = padding.hors }, "leftabove vnew", "wincmd l")
  pad_with_buffer({ hors = padding.hors }, "vnew", "wincmd h")
  pad_with_buffer({ vert = padding.vert }, "leftabove new", "wincmd j")
  pad_with_buffer({ vert = padding.vert }, "rightbelow new", "wincmd k")

end
