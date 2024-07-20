return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function(_, opts)
		vim.o.background = "light"
		vim.o.termguicolors = true

		require("gruvbox").setup(opts)

		vim.cmd([[colorscheme gruvbox]])
		vim.cmd([[highlight SignColumn guibg=NONE]])
	end,
}
