require("lspconfig").clangd.setup({
	cmd = {
		"clangd",
		-- "--compile-commands-dir=.",
	},
	capabilities = vim.tbl_deep_extend("force", require("cmp_nvim_lsp").default_capabilities(), {
		offsetEncoding = { "utf-8", "utf-16" },
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
	}),
})
