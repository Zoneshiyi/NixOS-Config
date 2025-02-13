local map = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1
	if not directory then
		return
	end
	-- create a new, empty buffer
	vim.cmd.enew()
	-- wipe the directory buffer
	vim.cmd.bw(data.buf)
	-- change to the directory
	vim.cmd.cd(data.file)
	-- open the tree
	require("nvim-tree.api").tree.open()
end

local opts = {
	update_focused_file = {
		enable = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
		change_dir = {
			global = true,
		},
	},
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 23,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
	on_attach = function(bufnr)
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, nowait = true }
		end
		local api = require("nvim-tree.api")
		-- default mappings
		api.config.mappings.default_on_attach(bufnr)
		-- custom mappings
		map("n", "<C-Enter>", api.tree.change_root_to_node, opts("CD"))
		map("n", "<C-h>", api.node.open.horizontal, opts("Open: Horizontal Split"))
	end,
}

local config = function()
	require("nvim-tree").setup(opts)
end

return {
	config = config,
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
	end,
	keys = {
		{
			"<C-b>",
			function()
				require("nvim-tree.api").tree.toggle({
					find_files = true,
					update_root = true,
				})
			end,
			mode = { "n" },
			desc = "NvimTree Toggle",
		},
	},
}
