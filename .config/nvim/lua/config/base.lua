vim.opt.exrc = true
vim.opt.mouse = ""
vim.opt.guicursor = ""
vim.opt.updatetime = 50
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.isfname:append("@-@")
vim.opt.shortmess:append({ I = true })

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.inccommand = "split"
vim.opt.formatoptions:remove "o"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.g.netrw_banner = false
vim.g.netrw_browse_split = false
vim.g.netrw_altv = true
vim.g.netrw_winsize = 25
vim.g.netrw_fastbrowse = false

vim.g.python_host_skip_check = true
vim.g.python3_host_skip_check = true
vim.g.loaded_python3_provider = false
