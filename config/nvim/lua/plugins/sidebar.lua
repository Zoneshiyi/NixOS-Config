return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "echasnovski/mini.icons" },
		},
		init = require("configs.tree").init,
		config = require("configs.tree").config,
		keys = require("configs.tree").keys,
	},
	{
		"folke/trouble.nvim",
		opts = require("configs.trouble").opts,
		keys = require("configs.trouble").keys,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		event = { "VimEnter" },
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		keys = require("configs.bufferline").keys,
		opts = require("configs.bufferline").opts,
	},
}
