require("configs.LS.clangd")
require("configs.LS.pyright")
require("configs.LS.nix")
require("configs.LS.lua_ls")

local map = vim.keymap.set
local merge = vim.tbl_deep_extend

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		map(
			"n",
			"<leader>ll",
			vim.diagnostic.setloclist,
			merge("force", opts, { desc = "Show diagnostics in loclist" })
		)

		map("n", "gd", vim.lsp.buf.definition, merge("force", opts, { desc = "Go to definition" }))
		map("n", "gD", vim.lsp.buf.declaration, merge("force", opts, { desc = "Go to declaration" }))
		map("n", "gi", vim.lsp.buf.implementation, merge("force", opts, { desc = "Go to implementation" }))
		-- map('n', 'gr', vim.lsp.buf.references, merge('force', opts, { desc = 'Go to references' }))
		-- map('n', 'K', vim.lsp.buf.hover, merge('force', opts, { desc = 'Lsp buf hover' }))

		map(
			"n",
			"<leader>wa",
			vim.lsp.buf.add_workspace_folder,
			merge("force", opts, { desc = "Add workspace folder" })
		)
		map(
			"n",
			"<leader>wr",
			vim.lsp.buf.remove_workspace_folder,
			merge("force", opts, { desc = "Remove workspace folder" })
		)
		map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, merge("force", opts, { desc = "List workspace folders" }))

		map("n", "<leader>lt", vim.lsp.buf.type_definition, merge("force", opts, { desc = "Goto type definition" }))
		map("n", "<leader>lr", vim.lsp.buf.rename, merge("force", opts, { desc = "Rename" }))
	end,
})
