local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- When started with a single directory, set cwd to that
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local argv = vim.fn.argv()
    if #argv == 2 then
      local arg = argv[2]
      local full = vim.fn.fnamemodify(arg, ":p")
      if vim.fn.isdirectory(full) == 2 then
        vim.cmd("cd " .. vim.fn.fnameescape(full))
      end
    end
  end,
})

-- Kitty margins
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      vim.cmd("silent !kitty @ set-spacing margin=1")
    end, 101)
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.cmd("silent !kitty @ set-spacing margin=3 0 0 4")
  end,
})

require 'core.options'
require 'core.keymaps'

require('lazy').setup({
    require 'plugins.bufferline',
    require 'plugins.colortheme',
    require 'plugins.neotree',
    require 'plugins.lualine',
    require 'plugins.treesitter',
    require 'plugins.telescope',
    -- require 'plugins.lsp', -- I don't really need this right now
    -- require 'plugins.autoformatting',
    require 'plugins.misc',
    require 'plugins.notifications',
    require 'plugins.indent',
})
