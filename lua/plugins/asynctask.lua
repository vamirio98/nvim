return {
	"skywind3000/asynctasks.vim",
	dependencies = {
		"skywind3000/asyncrun.vim",
	},
	init = function()
		vim.g.asyncrun_rootmarks = {
			".root",
			".git",
			".svn",
			".project",
		}
	end,
}
