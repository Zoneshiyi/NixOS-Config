require("lspconfig").pyright.setup({
	-- cmd = { 'pyright-langserver', '--stdio' },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

