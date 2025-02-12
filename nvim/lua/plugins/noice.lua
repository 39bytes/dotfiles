return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    presets = {
      bottom_search = true,
      command_palette = true,
    },
    lsp = {
      hover = {
        silent = true,
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
