return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = false,
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },

  config = function()
    require('neo-tree').setup {
      window = {
        width = 25,
        position = 'right',
        auto_expand_width = true,
      },
    }

    vim.keymap.set('n', '<leader>fe', '<cmd>Neotree toggle reveal<cr>', { desc = 'Toggle Neotree' })
  end,
}
