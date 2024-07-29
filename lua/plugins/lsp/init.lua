return {
	{
		"abecodes/tabout.nvim",
		priority = 30,
		opts = {},
		config = function(_, opts)
			require("tabout").setup(opts)

			-- for multiline
			local keyset = vim.keymap.set
			keyset("i", "<M-n>", "<Plug>(TaboutMulti)", { silent = true, desc = "Multiline tabout" })
		end,
	},

	{
		"honza/vim-snippets",
	},

	{
		"SirVer/ultisnips",
		dependencies = {
			"honza/vim-snippets",
		},
		init = function()
			vim.g.UltiSnipsSnippetDirectories = {
				"UltiSnips",
			}
			vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
			vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
			vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
			vim.g.UltiSnipsListSnippets = "<C-x><C-s>"
			vim.g.UltiSnipsRemoveSelectModeMappings = 0
		end,
	},

	{
		"hrsh7th/cmp-nvim-lsp",
	},

	{ "hrsh7th/cmp-buffer" },

	{ "hrsh7th/cmp-path" },

	{ "hrsh7th/cmp-cmdline" },

	{
		"quangnguyen30192/cmp-nvim-ultisnips",
		opts = {},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"SirVer/ultisnips",
			"quangnguyen30192/cmp-nvim-ultisnips",
		},
		config = function()
			local t = function(str)
				return vim.api.nvim_replace_termcodes(str, true, true, true)
			end

			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-l>"] = cmp.mapping(function()
						vim.api.nvim_feedkeys(t("<Plug>(ultisnips_expand)"), "m", true)
					end, { "i", "x" }),
					["<Tab>"] = cmp.mapping({
						c = function()
							if cmp.visible() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
							else
								cmp.complete()
							end
						end,
						i = function(fallback)
							if cmp.visible() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
							elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
								vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
							else
								fallback()
							end
						end,
						s = function(fallback)
							if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
								vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
							else
								fallback()
							end
						end,
					}),
					["<S-Tab>"] = cmp.mapping({
						c = function()
							if cmp.visible() then
								cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
							else
								cmp.complete()
							end
						end,
						i = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
							elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
								return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
							else
								fallback()
							end
						end,
						s = function(fallback)
							if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
								return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
							else
								fallback()
							end
						end,
					}),
					["<Down>"] = cmp.mapping(
						cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
						{ "i" }
					),
					["<Up>"] = cmp.mapping(
						cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
						{ "i" }
					),
					["<C-n>"] = cmp.mapping({
						c = function()
							if cmp.visible() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
							else
								vim.api.nvim_feedkeys(t("<Down>"), "n", true)
							end
						end,
						i = function(fallback)
							if cmp.visible() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
							else
								fallback()
							end
						end,
					}),
					["<C-p>"] = cmp.mapping({
						c = function()
							if cmp.visible() then
								cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
							else
								vim.api.nvim_feedkeys(t("<Up>"), "n", true)
							end
						end,
						i = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
							else
								fallback()
							end
						end,
					}),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({ select = true }),
						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "ultisnips" }, -- For ultisnips users.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				completion = { autocomplete = false },
				sources = {
					{ name = "buffer", option = { keyword_pattern = [=[[^[:blank:]].*]=] } },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				completion = { autocomplete = false },
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- setup completion for lsp in mason-lspconfig
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = {},
	},

	{
		"williamboman/mason.nvim",
		opts = {
			install_root_dir = vim.fn.expand("~/.config/nvim-data/mason"),
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		opts = {},

		config = function(client, opts)
			require("mason-lspconfig").setup(opts)

			-- Set up lspconfig.
			local on_attach = function(_, bufnr)
				local keyset = vim.keymap.set

				-- goto command
				keyset("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, silent = true, desc = "Go to declaration" })
				keyset("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, silent = true, desc = "Go to definition" })
				keyset("n", "gy", vim.lsp.buf.type_definition, { buffer = bufnr, silent = true, desc = "Go to type definition" })
				keyset("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, silent = true, desc = "Go to implementation" })
				keyset("n", "gr", vim.lsp.buf.references, { buffer = bufnr, silent = true, desc = "Go to references" })

				-- symbol rename
				keyset("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, silent = true, desc = "Rename symbol" })

				-- formatting code
				keyset("", "<space>fc", function()
					require("conform").format({ async = false, lsp_fallback = true })
				end, { buffer = bufnr, silent = true, desc = "Format code" })

				-- code action
				keyset("", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr, silent = true, desc = "Apply code action" })

				-- ui
				vim.api.nvim_create_autocmd("CursorHold", {
					buffer = bufnr,
					callback = function()
						local opts = {
							focusable = false,
							close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
							border = 'rounded',
							source = 'always',
							prefix = ' ',
							scope = 'cursor',
						}
						vim.diagnostic.open_float(nil, opts)
					end
				})

				--if client.server_capabilities.documentHighlightProvider then
				--	vim.cmd [[
				--		hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
				--		hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
				--		hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
				--	]]
				--	vim.api.nvim_create_augroup('lsp_document_highlight', {
				--		clear = false
				--	})
				--	vim.api.nvim_clear_autocmds({
				--		buffer = bufnr,
				--		group = 'lsp_document_highlight',
				--	})
				--	vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				--		group = 'lsp_document_highlight',
				--		buffer = bufnr,
				--		callback = vim.lsp.buf.document_highlight,
				--	})
				--	vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				--		group = 'lsp_document_highlight',
				--		buffer = bufnr,
				--		callback = vim.lsp.buf.clear_references,
				--	})
				--end
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
				["clangd"] = function()
					require("lspconfig")["clangd"].setup({
						capabilities = capabilities,
						cmd = {
							"clangd",
							"-header-insertion=never",
						},
						on_attach = on_attach,
					})
				end
			})
		end
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
		},
		init = function()
			vim.o.updatetime = 300
		end
	},
}
