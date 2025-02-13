return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				multiwindows = true,
        max_lines = 5,
        trim_scope = "inner",
			},
		},
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
	},
	{
		"stevearc/conform.nvim",
		-- event = { 'BufWritePre' },
		cmd = { "ConformInfo" },
		keys = require("configs.conform").keys,
		opts = require("configs.conform").opts,
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
