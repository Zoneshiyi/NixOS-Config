local builtin = require("telescope.builtin")
local opts = {
	extensions = {
		fzf = {
			-- false will only do exact matching
			fuzzy = true,
			-- override the generic sorter
			override_generic_sorter = true,
			-- override the file sorter
			override_file_sorter = true,
			-- 'smart_case' or 'ignore_case' or 'respect_case'
			case_mode = "smart_case",
		},
	},
}

return {
	config = function()
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
	end,
	keys = {
		{
			"<leader>ff",
			function()
				builtin.find_files()
			end,
			mode = { "n" },
			desc = "Telescope find files",
		},
		{
			"<leader>fg",
			function()
				builtin.live_grep()
			end,
			mode = { "n" },
			desc = "Telescope live grep",
		},
		{
			"<leader>fc",
			function()
				builtin.current_buffer_fuzzy_find()
			end,
			mode = { "n" },
			desc = "Telescope fuzzy buffer",
		},
		{
			"<leader>fb",
			function()
				builtin.buffers()
			end,
			mode = { "n" },
			desc = "Telescope buffers",
		},
		{
			"<leader>fB",
			function()
				builtin.builtin()
			end,
			mode = { "n" },
			desc = "Telescope builtin",
		},
		{
			"<leader>fh",
			function()
				builtin.help_tags()
			end,
			mode = { "n" },
			desc = "Telescope help tags",
		},
		{
			"<leader>fr",
			function()
				builtin.resume()
			end,
			mode = { "n" },
			desc = "Telescope resume",
		},
		{
			"<leader>fm",
			function()
				builtin.marks()
			end,
			mode = { "n" },
			desc = "Telescope marks",
		},
	},
}
