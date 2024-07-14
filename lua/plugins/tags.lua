return {
	{
		"ludovicchabant/vim-gutentags",
		init = function()
			vim.g.gutentags_project_root = {
				".root",
				".svn",
				".git",
				".project",
			}
			-- set ctags file name
			vim.g.gutentags_ctags_tagfile = ".tags"

			-- detect dir ~/.cache/tags, create new one if it doesn't eixst
			local tag_cache_dir = vim.fn.expand("~/.cache/tags")
			if vim.fn.isdirectory(tag_cache_dir) ~= 1 then
				vim.fn.mkdir(tag_cache_dir, "p")
			end
			vim.g.gutentags_cache_dir = tag_cache_dir

			-- use a ctags-compatible program to generate a tags file and GNU's
			-- gtags to generate a code database file
			local gutentags_modules = {}
			if vim.fn.executable("ctags") == 1 then
				table.insert(gutentags_modules, "ctags")
			end
			if vim.fn.executable("gtags-cscope") == 1 and vim.fn.executable("gtags") == 1 then
				table.insert(gutentags_modules, "gtags_cscope")
			end
			vim.g.gutentags_modules = gutentags_modules

			-- set ctags arguments
			vim.g.gutentags_ctags_extra_args = {
				"--fields=+niazS",
				"--extra=+q",
				"--c++-kinds=+px",
				"--c-kinds=+px",
				"--output-format=e-ctags", -- use universal-ctags
			}

			-- config gutentags whitelist
			vim.g.gutentags_exclude_filetypes = { "text" }

			-- Prevent gutentags from autoloading gtags database
			vim.g.gutentags_auto_add_gtags_cscope = 0
		end,
	},
	{
		"skywind3000/gutentags_plus",
		dependencies = {
			"ludovicchabant/vim-gutentags",
		},
		init = function()
			-- change focus to quickfix window after search
			vim.g.gutentags_plus_switch = 1
		end,
	},
}
