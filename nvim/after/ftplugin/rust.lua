local bufnr = vim.api.nvim_get_current_buf()
local function merge(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

local function map(mode, key, args, opts)
  vim.keymap.set(mode, key, function()
    vim.cmd.RustLsp(args)
  end, merge({ silent = true, buffer = bufnr }, opts))
end

map('n', '<leader>me', 'expandMacro', { desc = '[M]acro [E]xpand' })
map('n', '<leader>a', 'codeAction', { desc = 'Code [A]ction' })
map('n', '<leader>rd', 'debuggables', { desc = '[R]ust [D]ebuggables' })
