vim.wo.number = true
vim.o.relativenumber = true
vim.opt.clipboard = "unnamedplus" -- Link system clipboard
vim.o.wrap = false -- Don't wrap long lines
vim.o.linebreak = true -- Don't split words
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true -- Maintains indent from current line to next
vim.o.ignorecase = true -- Case insensitive searching
vim.o.smartcase = true -- Case sensitive when a capital letter is present
vim.o.scrolloff = 10 -- Minimal number of screen lines to keep above and below
vim.o.sidescrolloff = 8 -- Minimal number of columns right or left of cursor
vim.o.mouse = "a"
vim.o.autochdir = true -- cwd follows the directory of the current buffer's file
vim.o.cursorline = true
vim.o.showtabline = 1
vim.o.completeopt = "menuone,noselect"
vim.opt.termguicolors = true
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate vim from nvim
vim.opt.fillchars = { eob = " " }
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.o.splitright = true -- Configure how new splits should be opened
vim.o.splitbelow = true
vim.o.inccommand = "split" -- Preview substitutions live, as you type!
vim.o.confirm = true -- See :help confirm
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.g.have_nerd_font = true

