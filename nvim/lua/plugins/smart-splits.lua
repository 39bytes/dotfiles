return {
  'mrjones2014/smart-splits.nvim',
  build = './kitty/install-kittens.bash',
  lazy = false,
  init = function()
    vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
    vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
    vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
    vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
    vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
    -- swapping buffers between windows
    vim.keymap.set('n', '<C-w>h', require('smart-splits').swap_buf_left)
    vim.keymap.set('n', '<C-w>j', require('smart-splits').swap_buf_down)
    vim.keymap.set('n', '<C-w>k', require('smart-splits').swap_buf_up)
    vim.keymap.set('n', '<C-w>l', require('smart-splits').swap_buf_right)
  end,
}
