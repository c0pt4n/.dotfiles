require("utils.pack").add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		build = "TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
				modules = {},
				ignore_install = {},
				ensure_installed = {
					"c",
					"python",
					"lua",
					"bash",
					"vimdoc",
					"html",
					"todotxt"
				},
			})
		end,
	},
})
