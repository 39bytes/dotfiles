return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  enabled = false,
  config = function()
    require('bufferline').setup {}
    vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<CR>')
    vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<CR>')
    vim.keymap.set('n', '<leader>O', '<cmd>BufferLineCloseOthers<CR>')
  end,
}
