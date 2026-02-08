return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
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
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({ max_lines = 5 })
		end,
	},
}
