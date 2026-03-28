local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Kitty margins
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		os.execute("kitty @ set-spacing margin=0")
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		os.execute("kitty @ set-spacing margin=4")
	end,
})

require("core.options")
require("core.keymaps")

require("lazy").setup({
	require("plugins.bufferline"),
	require("plugins.colortheme"),
	require("plugins.neotree"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.autoformatting"),
	require("plugins.autocompletion"),
	require("plugins.misc"),
	require("plugins.notifications"),
	require("plugins.indent"),
})
