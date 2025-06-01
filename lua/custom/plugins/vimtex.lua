---@type LazySpec
return {
  'lervag/vimtex',
  init = function(_)
    vim.g.vimtex_quickfix_open_on_warning = 0
  end,
}
