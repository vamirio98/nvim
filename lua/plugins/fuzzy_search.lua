return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		init = function()
			local keyset = vim.keymap.set
			local builtin = require("telescope.builtin")
			keyset("n", "<space>ff", builtin.find_files, {})
			keyset("n", "<space>fg", builtin.live_grep, {})
			keyset("n", "<space>fb", builtin.buffers, {})
			keyset("n", "<space>fc", builtin.commands, {})
			keyset("n", "<space>ft", builtin.tags, {})
			keyset("n", "<space>fr", builtin.oldfiles, {})
			keyset("n", "<space>fh", builtin.help_tags, {})
			keyset("n", "<space>fs", "<Cmd>Telescope<CR>", {})

			-- enable telescope-fzf-native extension
			require("telescope").load_extension("fzf")
		end,
		opts = {
			defaults = {
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
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = function(plugin)
			local obj = vim.system({ "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release" }, { cwd = plugin.dir })
				:wait()
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
