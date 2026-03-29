vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- so it's easier to mapleader
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)

-- save file, no auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> qa <CR>", opts)
vim.keymap.set("n", "<leader>[]", "<cmd> qa! <CR>", opts)

-- copy all
vim.keymap.set("v", "<leader>a", "ggOG", opts)
vim.keymap.set("n", "<leader>a", ":%y+<CR>", opts)

-- delete character without copying into register
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("n", "dd", '"_dd', opts)

-- vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- clear highlighting easily
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
-- vim.keymap.set('n', '<C-i>', '<C-i>', opts) -- to restore jump forward
vim.keymap.set("n", "<leader>x", ":Bdelete!<CR>", opts) -- close buffer
-- vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- window management
-- vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
-- vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
-- vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
-- vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- tabs
-- vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
-- vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
-- vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
-- vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- easy indent blocks
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- press jk fast to exit insert mode
vim.keymap.set("i", "jk", "<ESC>", opts)
vim.keymap.set("i", "kj", "<ESC>", opts)

-- move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

-- keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- LSP!!!
-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false,

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = { float = true },
})

-- Open quickfix list with errors
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
