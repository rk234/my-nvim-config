---@type LazySpec
return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup {
      padding = true,
    }

    vim.keymap.set('n', '<leader>/', 'gc')
    vim.keymap.set('x', '<leader>/', 'gcc')
    vim.keymap.set('v', '<leader>/', 'gbc')
  end,
}
