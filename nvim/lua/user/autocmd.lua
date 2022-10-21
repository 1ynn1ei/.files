vim.cmd [[
  augroup _lsp
    autocmd!
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
  augroup end
  ]]
