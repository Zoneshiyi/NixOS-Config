local opts = {
	ensure_installed = {
		"c",
		"python",
		"nix",
		"lua",
	},
	sync_install = false,
	auto_install = false,
	highlight = {
		enable = true,
		-- names of the parsers, not the filetypes
		-- disable = {'',''},
	},
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<TAB>",
		},
	},
}

local configs = require("nvim-treesitter.configs")
configs.setup(opts)
