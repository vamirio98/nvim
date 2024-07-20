return {
	{
		"honza/vim-snippets",
	},

	{
		"SirVer/ultisnips",
		dependencies = {
			"honza/vim-snippets",
		},
		config = function()
			vim.g.UltiSnipsSnippetDirectories = {
				"UltiSnips",
			}
			vim.g.UltiSnipsExpandTrigger = "<C-l>"
			vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
		end,
	},
}
