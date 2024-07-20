return {
	{
		"skywind3000/asyncrun.vim",
		config = function()
			vim.g.asyncrun_rootmarks = {
				".root",
				".git",
				".svn",
				".project",
			}
		end,
	},

	{
		"skywind3000/asynctasks.vim",
		dependencies = {
			"skywind3000/asyncrun.vim",
		},
	},
}
