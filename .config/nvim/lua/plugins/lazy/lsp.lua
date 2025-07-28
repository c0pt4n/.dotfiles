vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf, remap = false }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>af", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>ak", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>aj", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, opts)
	end
})

vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = true,
	float = {
		border = "rounded",
		source = true,
	},
})

return {
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		build = ":MasonUpdate",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {}, build = ":MasonUpdate" },
			{ "neovim/nvim-lspconfig" },
		},
		config = function()
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"gopls",
					"pyright",
					"lua_ls",
					"zk",
				},
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						staticcheck = true,
						gofumpt = true,
						analyses = {
							unusedparams = true,
							unusedvariable = true,
							unusedwrite = true,
						},
					},
				},
			})
		end,
	},
}

