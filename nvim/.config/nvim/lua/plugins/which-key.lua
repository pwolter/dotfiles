return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		-- Names for the <leader> prefix groups so pressing <space> shows
		-- meaningful category labels instead of "➜ +N keymaps".
		spec = {
			{ "<leader>b", group = "Debug: breakpoints" },
			{ "<leader>c", group = "Diff / merge" },
			{ "<leader>d", group = "Debug (DAP)" },
			{ "<leader>e", group = "Explorer (nvim-tree)" },
			{ "<leader>f", group = "Find (Telescope)" },
			{ "<leader>g", group = "LSP / Goto / Git" },
			{ "<leader>h", group = "Harpoon" },
			{ "<leader>i", group = "Images" },
			{ "<leader>m", group = "Markdown" },
			{ "<leader>mr", group = "Markdown: render" },
			{ "<leader>ms", group = "Markdown: spell" },
			{ "<leader>o", group = "Obsidian" },
			{ "<leader>ol", group = "Obsidian: follow link" },
			{ "<leader>q", group = "Quit / Quickfix" },
			{ "<leader>r", group = "Rename" },
			{ "<leader>s", group = "Split / window" },
			{ "<leader>sm", group = "Split: move to window" },
			{ "<leader>t", group = "Tabs" },
			{ "<leader>w", group = "Write / save" },
			{ "<leader>x", group = "REST client" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
