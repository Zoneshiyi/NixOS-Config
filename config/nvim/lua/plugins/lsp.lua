return {
	{
		"neovim/nvim-lspconfig",
		ft = {
			"c",
			"cpp",
			"python",
      "nix",
			"lua",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("configs.lspconfig")
		end,
	},
}
