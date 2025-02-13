return {
	opts = {
		options = {
			offsets = {
				{
					text = "File Explorer",
					filetype = "NvimTree",
					highlight = "Directory",
					text_align = "left",
					separator = true,
				},
			},
	}
	},
	keys = {
		{ "<C-S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev bufferline" },
		{ "<C-Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next bufferline" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close others bufferline" },
		{ "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "Pick bufferline" },
		{ "<leader>bc", "<cmd>BufferLinePickClose<CR>", desc = "Pick bufferline to close" },
	},
}
