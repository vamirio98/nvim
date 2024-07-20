return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		-- It MUST be at the beginning of runtimepath. Otherwise the parsers from Neovim itself
		-- is loaded that may not be compatible with the queries from the 'nvim-treesitter' plugin.
		local parser_dir = vim.fn.expand("~/.config/nvim-data/treesitter")
		vim.opt.runtimepath:prepend(parser_dir)

		require("nvim-treesitter.configs").setup({
			parser_install_dir = parser_dir,
			highlight = {
				enable = true,
				-- disable slow treesitter highlight for large files
				-- NOTE: {lang} is the name of the parsers and not the filetype
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
		})
	end,
	build = ":TSUpdate",
}
