return {
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			python = { "isort", "black" },
      nix = { "nixfmt" },
			lua = { "stylua" },
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},

		-- Set up format-on-save
		format_on_save = nil,
		-- Customize formatters
		-- formatters = {
		--   shfmt = {
		--     prepend_args = { '-i', '2' },
		--   },
		-- },
	},
	keys = {
		{
			"<A-f>",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer",
		},
	},
}
