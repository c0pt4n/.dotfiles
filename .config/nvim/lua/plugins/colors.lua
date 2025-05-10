return {
	{
		'f4z3r/gruvbox-material.nvim',
		name = 'gruvbox-material',
		lazy = false,
		priority = 1000,
		config = function()
			require('gruvbox-material').setup({
				background = {
					transparent = true,
				}
			})
		end,
	},
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })

			vim.cmd.colorscheme("rose-pine-moon")
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    },
}
