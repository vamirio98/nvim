return {
	"neoclide/coc.nvim",
	priority = 30,
	branch = "release",
	config = function()
		-- some servers have issues with backup files
		vim.opt.backup = false
		vim.opt.writebackup = false

		vim.opt.updatetime = 300

		vim.opt.signcolumn = "yes"

		local keyset = vim.keymap.set

		function _G.check_back_space()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
		end

		local opts = { silent = true, expr = true, replace_keycodes = false }
		keyset(
			"i",
			"<tab>",
			'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
			opts
		)
		keyset("i", "<S-tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

		-- make <CR> to accept selected completion item or notify coc.nvim to format
		keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

		-- toggle completion
		keyset("i", "<C-space>", "coc#pum#visible() ? coc#pum#stop() : coc#refresh()", { silent = true, expr = true })

		-- navigate diagnostics
		keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true, desc = "To next diagnostic" })
		keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true, desc = "To prev diagnostic" })

		-- goto code navigation
		keyset("n", "gd", "<Plug>(coc-definition)", { silent = true, desc = "To definition" })
		keyset("n", "gD", "<Plug>(coc-declaration)", { silent = true, desc = "To declaration" })
		keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true, desc = "To type declaration" })
		keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true, desc = "To implementation" })
		keyset("n", "gr", "<Plug>(coc-reference)", { silent = true, desc = "To reference" })

		-- use K to show documentation in preview window
		function _G.show_docs()
			local cw = vim.fn.expand("<cword>")
			if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
				vim.api.nvim_command("h " .. cw)
			elseif vim.api.nvim_eval("coc#rpc#ready()") then
				vim.fn.CocActionAsync("doHover")
			else
				vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
			end
		end
		keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

		-- highlight the symbol and its references on a CursorHold event(cursor is idle)
		vim.api.nvim_create_augroup("MyCocGroup", {})
		vim.api.nvim_create_autocmd("CursorHold", {
			group = "MyCocGroup",
			command = "silent call CocActionAsync('highlight')",
			desc = "Highlight symbol under cursor on CursorHold",
		})

		-- symbol renaming
		keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true, desc = "Rename symbol" })

		-- formatting code
		keyset("x", "<space>fc", "<Plug>(coc-format-selected)", { silent = true, desc = "Format code" })
		keyset("n", "<space>fc", "<Cmd>call CocAction('format')<CR>", { desc = "Format code" })

		-- setup formatexpr specified filetype(s)
		vim.api.nvim_create_autocmd("FileType", {
			group = "MyCocGroup",
			pattern = "typescript,json",
			command = "setlocal formatexpr=CocAction('formatSelected')",
			desc = "Setup formatexpr specified filetype(s).",
		})

		-- update signature help on jump placeholder
		vim.api.nvim_create_autocmd("User", {
			group = "MyCocGroup",
			pattern = "CocJumpPlaceholder",
			command = "call CocActionAsync('showSignatureHelp')",
			desc = "Update signature help on jump placeholder",
		})

		-- apply codeAction to the selected region
		-- example: `<leader>aap` for current paragraph
		keyset(
			"x",
			"<leader>a",
			"<Plug>(coc-codeaction-selected)",
			{ silent = true, nowait = true, desc = "Apply code action for selected" }
		)

		-- remap keys for apply code actions at the cursor position.
		keyset(
			"n",
			"<leader>ac",
			"<Plug>(coc-codeaction-cursor)",
			{ silent = true, nowait = true, desc = "Apply code action at cursor position" }
		)
		-- remap keys for apply source code actions for current file.
		keyset(
			"n",
			"<leader>as",
			"<Plug>(coc-codeaction-source)",
			{ silent = true, nowait = true, desc = "Apply code action for current file" }
		)
		-- apply the most preferred quickfix action on the current line.
		keyset(
			"n",
			"<leader>qf",
			"<Plug>(coc-fix-current)",
			{ silent = true, nowait = true, desc = "Apply quickfix on current line" }
		)

		-- remap keys for apply refactor code actions.
		keyset("n", "<leader>rf", "<Plug>(coc-codeaction-refactor)", { silent = true, desc = "Refactor code" })
		keyset("x", "<leader>rf", "<Plug>(coc-codeaction-refactor-selected)", { silent = true, desc = "Refactor code" })

		-- run the Code Lens actions on the current line
		keyset(
			"n",
			"<leader>cl",
			"<Plug>(coc-codelens-action)",
			{ silent = true, nowait = true, desc = "Run Code Lens action on current line" }
		)

		-- map function and class text objects
		-- NOTE: requires 'textDocument.documentSymbol' support from the language server
		keyset("x", "if", "<Plug>(coc-funcobj-i)", { silent = true, nowait = true, desc = "inner function" })
		keyset("o", "if", "<Plug>(coc-funcobj-i)", { silent = true, nowait = true, desc = "inner function" })
		keyset("x", "af", "<Plug>(coc-funcobj-a)", { silent = true, nowait = true, desc = "function" })
		keyset("o", "af", "<Plug>(coc-funcobj-a)", { silent = true, nowait = true, desc = "function" })
		keyset("x", "ic", "<Plug>(coc-classobj-i)", { silent = true, nowait = true, desc = "inner class" })
		keyset("o", "ic", "<Plug>(coc-classobj-i)", { silent = true, nowait = true, desc = "inner class" })
		keyset("x", "ac", "<Plug>(coc-classobj-a)", { silent = true, nowait = true, desc = "class" })
		keyset("o", "ac", "<Plug>(coc-classobj-a)", { silent = true, nowait = true, desc = "class" })

		-- remap <C-f> and <C-b> to scroll float windows/popups
		---@diagnostic disable-next-line: redefined-local
		local opts = { silent = true, nowait = true, expr = true }
		keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
		keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
		keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
		keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
		keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
		keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

		-- add `:OR` command for organize imports of the current buffer
		vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

		-- mappings for CoCList
		-- code actions and coc stuff
		-- Show all diagnostics
		keyset(
			"n",
			"<space>cd",
			":<C-u>CocList diagnostics<cr>",
			{ silent = true, nowait = true, desc = "Show all coc diagnostics" }
		)
		-- Manage extensions
		keyset(
			"n",
			"<space>ce",
			":<C-u>CocList extensions<cr>",
			{ silent = true, nowait = true, desc = "Manage coc extensions" }
		)
		-- Show commands
		keyset(
			"n",
			"<space>cc",
			":<C-u>CocList commands<cr>",
			{ silent = true, nowait = true, desc = "Show coc commands" }
		)
		-- Find symbol of current document
		keyset(
			"n",
			"<space>cs",
			":<C-u>CocList outline<cr>",
			{ silent = true, nowait = true, desc = "Find symbol of current document" }
		)
		-- Search workspace symbols
		keyset(
			"n",
			"<space>cS",
			":<C-u>CocList -I symbols<cr>",
			{ silent = true, nowait = true, desc = "Search workspace symbols" }
		)
		-- Do default action for next item
		keyset(
			"n",
			"<space>cj",
			":<C-u>CocNext<cr>",
			{ silent = true, nowait = true, desc = "Do default action for next item" }
		)
		-- Do default action for previous item
		keyset(
			"n",
			"<space>ck",
			":<C-u>CocPrev<cr>",
			{ silent = true, nowait = true, desc = "Do default action for prev item" }
		)
		-- Resume latest coc list
		keyset(
			"n",
			"<space>cp",
			":<C-u>CocListResume<cr>",
			{ silent = true, nowait = true, desc = "Resume latest coc list" }
		)
	end,
}
