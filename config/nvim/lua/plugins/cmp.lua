return {
	{
		"github/copilot.vim",
		event = { "InsertEnter", "CmdlineEnter" },
		init = function()
			vim.api.nvim_set_keymap("i", "<C-i>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
	},
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		config = true,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("configs.cmp")
		end,
	},
}
