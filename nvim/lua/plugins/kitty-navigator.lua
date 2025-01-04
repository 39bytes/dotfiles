return {
  'MunsMan/kitty-navigator.nvim',
  build = {
    'cp navigate_kitty.py ~/.config/kitty',
    'cp pass_keys.py ~/.config/kitty',
  },
  opts = { keybindings = {} },
}
