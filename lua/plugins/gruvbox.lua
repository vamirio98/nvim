return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	init = function()
		vim.o.background = "light"
		vim.o.termguicolors = true
		vim.cmd([[colorscheme gruvbox]])
	end,
	opts = {},
}
