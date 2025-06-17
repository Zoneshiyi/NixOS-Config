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
				require('telescope.builtin').find_files()
			end,
			mode = { "n" },
			desc = "Telescope find files",
		},
		{
			"<leader>fg",
			function()
				require('telescope.builtin').live_grep()
			end,
			mode = { "n" },
			desc = "Telescope live grep",
		},
		{
			"<leader>fc",
			function()
				require('telescope.builtin').current_buffer_fuzzy_find()
			end,
			mode = { "n" },
			desc = "Telescope fuzzy buffer",
		},
		{
			"<leader>fb",
			function()
				require('telescope.builtin').buffers()
			end,
			mode = { "n" },
			desc = "Telescope buffers",
		},
		{
			"<leader>fB",
			function()
				require('telescope.builtin').builtin()
			end,
			mode = { "n" },
			desc = "Telescope builtin",
		},
		{
			"<leader>fh",
			function()
				require('telescope.builtin').help_tags()
			end,
			mode = { "n" },
			desc = "Telescope help tags",
		},
		{
			"<leader>fr",
			function()
				require('telescope.builtin').resume()
			end,
			mode = { "n" },
			desc = "Telescope resume",
		},
		{
			"<leader>fm",
			function()
				require('telescope.builtin').marks()
			end,
			mode = { "n" },
			desc = "Telescope marks",
		},
	},
}
