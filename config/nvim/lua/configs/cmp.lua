local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- Let's configure the item's appearance
-- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
local formatting = {
	-- Set order from left to right
	-- kind: single letter indicating the type of completion
	-- abbr: abbreviation of 'word'; when not empty it is used in the menu instead of 'word'
	-- menu: extra text for the popup menu, displayed after 'word' or 'abbr'
	fields = { "abbr", "menu" },

	-- customize the appearance of the completion menu
	format = function(entry, vim_item)
		vim_item.menu = ({
			nvim_lsp = "[Lsp]",
			luasnip = "[Luasnip]",
			buffer = "[File]",
			path = "[Path]",
			cmdline = "[Cmdline]",
		})[entry.source.name]
		return vim_item
	end,
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- Use <C-b/f> to scroll the docs
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		-- Use <C-k/j> to switch in items
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Use <CR>(Enter) to confirm selection
		-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		-- ['<C-e>'] = cmp.mapping.abort(),

		-- A super tab
		-- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }), -- i - insert mode; s - select mode
	}),

	formatting = formatting,

	-- Set source precedence
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		-- { name = 'cmdline' },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	formatting = formatting,
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})
