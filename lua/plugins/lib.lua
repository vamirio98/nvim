return {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},

	{
		"MunifTanjim/nui.nvim",
		lazy = true,
	},

	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				mappings = {
					i = {
						["<ESC>"] = "Close",
					},
				},
			},
		},
	},
}
