return {
  'github/copilot.vim',
  event = 'VeryLazy',
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.keymap.del('i', '<Tab>')

    vim.keymap.set('i', '<C-J>', 'copilot#Accept()', {
      expr = true,
      silent = true,
      replace_keycodes = false,
    })
    vim.keymap.set('i', '<C-K>', 'copilot#Next()', {
      expr = true,
      silent = true,
    })
  end,
}
