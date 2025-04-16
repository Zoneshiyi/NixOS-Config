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
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  }
}
