---@type LazySpec
return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup {
      padding = true,
    }

    vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, desc = 'Toggle comment line' })
    vim.keymap.set('x', '<leader>/', 'gc', { remap = true, desc = 'Toggle comment' })
  end,
}
