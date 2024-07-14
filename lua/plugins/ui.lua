return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				right_mouse_command = "vertical sbuffer %d",
			},
		},
		init = function()
			local keyset = vim.keymap.set
			keyset("n", "gb", "<Cmd>BufferLinePick<CR>", { desc = "To buffer", silent = true })
			keyset("n", "gB", "<Cmd>BufferLinePickClose<CR>", { desc = "Close buffer", silent = true })
			keyset("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { desc = "To prev buffer", silent = true })
			keyset("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { desc = "To next buffer", silent = true })
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init = function()
			vim.o.showmode = false
		end,
		opts = {},
	},

	{
		"mhinz/vim-startify",
		init = function()
			vim.g.startify_enable_special = 0
			vim.g.startify_custom_header = {}
		end,
	},

	{
		"bfrg/vim-cpp-modern",
	},

	{
		"voldikss/vim-floaterm",
		init = function()
			-- close window if the job exits normally
			vim.g.floaterm_autoclose = 1

			vim.g.floaterm_keymap_toggle = "<M-=>"
			vim.g.floaterm_keymap_new = "<M-+>"
			vim.g.floaterm_keymap_prev = "<M-,>"
			vim.g.floaterm_keymap_next = "<M-.>"
			vim.g.floaterm_keymap_kill = "<M-->"

			-- kill all floaterm instance when quit neovim
			vim.api.nvim_create_augroup("MyFloatermGroup", {})
			vim.api.nvim_create_autocmd("QuitPre", {
				pattern = "*",
				command = "FloatermKill!",
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { highlight = highlight },
		},
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- need rainbow-delimiters.nvim
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			local config = require("ibl.config").default_config
			config.indent.tab_char = config.indent.char
			config.scope.highlight = highlight

			require("ibl").setup(config)

			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
	},

	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				mappings = {
					i = {
						["<ESC>"] = "Close",
					},
				},
			},
		},
	},

	{
		"MunifTanjim/nui.nvim",
		init = function()
			local keyset = vim.keymap.set

			keyset("n", "<space>m", function()
				local Popup = require("nui.popup")
				local event = require("nui.utils.autocmd").event

				local popup = Popup({
					enter = true,
					focusable = true,
					border = {
						style = "rounded",
					},
					position = "50%",
					size = {
						width = "80%",
						height = "60%",
					},
				})

				-- mount/open the component
				popup:mount()

				-- unmount component when cursor leaves buffer
				popup:on(event.BufLeave, function()
					popup:unmount()
				end)

				-- set content
				vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { "Hello World" })
			end)
		end,
	},
}
