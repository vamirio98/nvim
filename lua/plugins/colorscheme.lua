return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		overrides = {
			GitSignsAdd = { link = "GruvboxGreenSign" },
			GitSignsChange = { link = "GruvboxOrangeSign" },
			GitSignsDelete = { link = "GruvboxRedSign" },
		},
	},
	init = function()
		vim.o.background = "light"
	end,
	config = function(_, opts)
		require("gruvbox").setup(opts)

		vim.cmd([[colorscheme gruvbox]])
	end,
}
