---@type LazySpec
return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'main',
  lazy = false,
  config = function()
    -- In the nvim-treesitter rewrite (required for Nvim 0.12+), highlighting is
    -- no longer enabled automatically. Enable it for every filetype via autocmd.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
