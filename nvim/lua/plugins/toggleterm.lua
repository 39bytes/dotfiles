return {
  'akinsho/toggleterm.nvim',
  version = '*',
  enabled = false,
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<C-\>]],
    }
  end,
}
