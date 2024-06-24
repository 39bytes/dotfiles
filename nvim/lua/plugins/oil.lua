return {
  'stevearc/oil.nvim',
  enabled = false,
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {}
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open oil' })
  end,
}
