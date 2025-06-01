-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>e', ':Neotree toggle<CR>', desc = 'NeoTree reveal', silent = true },
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      filesystem = {
        hijack_netrw_behavior = 'open_current',
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
      default_component_configs = {
        icon = {
          provider = function(icon, node) -- setup a custom icon provider
            local text, hl
            local mini_icons = require 'mini.icons'
            if node.type == 'file' then -- if it's a file, set the text/hl
              text, hl = mini_icons.get('file', node.name)
            elseif node.type == 'directory' then -- get directory icons
              text, hl = mini_icons.get('directory', node.name)
              -- only set the icon text if it is not expanded
              if node:is_expanded() then
                text = nil
              end
            end

            -- set the icon text/highlight only if it exists
            if text then
              icon.text = text
            end
            if hl then
              icon.highlight = hl
            end
          end,
        },
        kind_icon = {
          provider = function(icon, node)
            local mini_icons = require 'mini.icons'
            icon.text, icon.highlight = mini_icons.get('lsp', node.extra.kind.name)
          end,
        },
      },
    }

    if vim.bo.filetype == 'netrw' and vim.b.netrw_method == nil then
      vim.defer_fn(function()
        vim.cmd('enew | Neotree current dir=' .. vim.b.netrw_curdir)
      end, 0)
    end
  end,
}
