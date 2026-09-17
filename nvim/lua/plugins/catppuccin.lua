return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    no_italic = true,
    custom_highlights = function(colors)
      return {
        Type = { fg = colors.sapphire },
        Structure = { fg = colors.sapphire },
        ['@constructor'] = { fg = colors.sapphire },
        ['@module'] = { fg = colors.sapphire },
        Include = { fg = colors.pink },
        Keyword = { fg = colors.pink },
        ['@keyword.export'] = { fg = colors.pink },
        ['@keyword.return'] = { fg = colors.pink },
        ['@keyword.end'] = { fg = colors.pink },
        ['@keyword.function'] = { fg = colors.pink },
        ['@variable.parameter'] = { fg = colors.yellow },
        ['@function.builtin'] = { fg = colors.blue },
        Directory = { fg = colors.mauve },
        MiniFilesBorder = { fg = colors.mauve },
        MiniFilesBorderModified = { fg = colors.teal },
        MiniFilesTitle = { fg = colors.teal },
        MiniFilesTitleFocused = { fg = colors.teal },
        FzfLuaBorder = { fg = colors.mauve },
        FzfLuaFzfBorder = { fg = colors.mauve },
        FzfLuaFzfPrompt = { fg = colors.teal },
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
