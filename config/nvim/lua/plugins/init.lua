return {
	{
		"nvim-lua/plenary.nvim",
		event = "VeryLazy",
	},
	{
		"folke/which-key.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			require("configs.which-key")
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = true,
	},
	{
		"akinsho/toggleterm.nvim",
		keys = require("configs.toggleterm").keys,
		opts = require("configs.toggleterm").opts,
	},
}
