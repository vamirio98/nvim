return {
	{
		"jiangmiao/auto-pairs",
		init = function()
			vim.g.AutoPairsFlyMode = 1
			vim.g.AutoPairsShortcutBackInsert = "<M-b>"
		end,
	},

	{
		"justinmk/vim-dirvish",
		config = function()
			function _G.setup_dirvish()
				if vim.bo.buftype ~= "nofile" and vim.bo.filetype ~= "dirvish" then
					return
				end

				-- get current filename
				local text = vim.fn.getline(".")
				if vim.g.dirvish_hide_visible ~= 1 then
					vim.cmd([[silent! keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _]])
				end
				-- sort filename
				vim.cmd("sort ,^.*[\\/],")
				local name = "^" .. vim.fn.escape(text, ".*[]~\\") .. "[/*|@=|\\\\*]\\=\\%($\\|\\s\\+\\)"
				-- locate to current file
				vim.fn.search(name, "wc")
				vim.keymap.set("n", "~", "<Cmd>Dirvish ~<CR>", { silent = true, noremap = true, buffer = true })
			end

			vim.api.nvim_create_augroup("MyDirvishGroup", {})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dirvish",
				command = "lua _G.setup_dirvish()",
			})
		end,
	},

	{
		"smoka7/hop.nvim",
		init = function()
			local keyset = vim.keymap.set
			keyset({ "n", "v" }, "<leader>f", "<Cmd>HopChar1<CR>", {
				silent = true,
				desc = "Hop 1 char",
			})
		end,
		opts = {},
	},

	{
		"andymass/vim-matchup",
		init = function()
			vim.g.matchup_matchparen_offscreen = {
				method = "popup",
			}
		end,
		opts = {},
	},

	{
		"axelf4/vim-strip-trailing-whitespace",
	},
}