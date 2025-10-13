local function map(m, k, v)
	vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("x", "<leader>p", [["_dP]])
map({"n", "v"}, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({"n", "v"}, "<leader>d", [["_d]])
map("n", "<leader>t", ":split term://zsh<cr>")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

map("n", "<leader>wv", "<C-w>v")
map("n", "<leader>ws", "<C-w>s")
map("n", "<leader>wo", "<C-w>o")
map("n", "<leader>wc", "<C-w>c")
map("n", "<leader>wj", "<C-w>j")
map("n", "<leader>wk", "<C-w>k")
map("n", "<leader>wh", "<C-w>h")
map("n", "<leader>wl", "<C-w>l")
map("n", "<leader>w=", "<C-w>=")

map("n", "<leader>k", "<cmd>cnext<cr>zz")
map("n", "<leader>j", "<cmd>cprev<cr>zz")
map("n", "<leader>K", "<cmd>lnext<cr>zz")
map("n", "<leader>J", "<cmd>lprev<cr>zz")

map("n", "Q", ":Ex<cr>")
map("i", "<C-c>", "<esc>")
map("n", "<C-t>", "<cmd>tabnew<cr>")

map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
map("n", "<leader><leader>", function()
    vim.cmd("so")
end)
