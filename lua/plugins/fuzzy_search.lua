return {
	{
		"nvim-telescope/telescope.nvim",
		priority = 30,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		opts = {
			defaults = {
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<M-h>"] = require("telescope.actions").preview_scrolling_left,
						["<M-j>"] = require("telescope.actions").preview_scrolling_down,
						["<M-k>"] = require("telescope.actions").preview_scrolling_up,
						["<M-l>"] = require("telescope.actions").preview_scrolling_right,
						["<ESC>"] = require("telescope.actions").close,
					},
				},
			},
		},
		config = function(_, opts)
			local keyset = vim.keymap.set
			local builtin = require("telescope.builtin")
			keyset("n", "<space>ff", builtin.find_files, { desc = "Search file" })
			keyset("n", "<space>fg", builtin.live_grep, { desc = "Search string (grep)" })
			keyset("n", "<space>fb", builtin.buffers, { desc = "Search buffer" })
			keyset("n", "<space>fC", builtin.commands, { desc = "Search command" })
			keyset("n", "<space>ft", builtin.tags, { desc = "Search tag" })
			keyset("n", "<space>fr", builtin.oldfiles, { desc = "Search recently used files" })
			keyset("n", "<space>fh", builtin.help_tags, { desc = "Search help" })
			keyset("n", "<space>fs", "<Cmd>Telescope<CR>", { desc = "Open telescope" })

			require("telescope").setup(opts)

			-- enable telescope-fzf-native extension
			require("telescope").load_extension("fzf")
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = function(plugin)
			local obj = vim.system({ "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release" }, { cwd = plugin.dir }):wait()
			if obj.code ~= 0 then
				error(obj.stderr)
			end
			obj = vim.system({ "cmake", "--build", "build", "--config", "Release" }, { cwd = plugin.dir }):wait()
			if obj.code ~= 0 then
				error(obj.stderr)
			end
			obj = vim.system({ "cmake", "--install", "build", "--prefix", "build" }, { cwd = plugin.dir }):wait()
			if obj.code ~= 0 then
				error(obj.stderr)
			end
		end,
	},
}
