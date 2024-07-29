local keyset = vim.keymap.set
-- set <leader> key
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = "\\"
vim.g.maplocalleader = "_"

-- disable alt on GUI, make it can be used for mapping
vim.opt.winaltkeys = "no"

vim.cmd([[
  if $TMUX != ''
    set ttimeoutlen=30
  elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
    set ttimeoutlen=80
  endif
]])

keyset("n", "<M-q>", "<ESC>")

-- clear search with <ESC>
keyset({ "i", "n" }, "<ESC>", "<Cmd>noh<CR><ESC>", { desc = "Escape and clear hlsearch" })

keyset({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keyset({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

keyset("n", "<space>z", "za", { desc = "toggle fold" })

-- resize window
keyset("n", "<M-up>", "<C-w>+", { desc = "increase window vertically" })
keyset("n", "<M-down>", "<C-w>-", { desc = "reduce window vertically" })
keyset("n", "<M-left>", "<C-w><", { desc = "increase window horizontally" })
keyset("n", "<M-right>", "<C-w>>", { desc = "reduce window horizontally" })

keyset({ "n", "i", "v" }, "<C-s>", "<Cmd>update<CR>")

keyset({ "i", "c" }, "<C-a>", "<home>")
keyset({ "i", "c" }, "<C-e>", "<end>")

keyset("n", "<M-x>", "<Cmd>bdelete<CR>")

keyset("n", "<M-H>", "<C-w>h")
keyset("n", "<M-J>", "<C-w>j")
keyset("n", "<M-K>", "<C-w>k")
keyset("n", "<M-L>", "<C-w>l")

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
keyset("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostic" })
keyset("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
keyset("n", "[d", diagnostic_goto(false), { desc = "Prev diagnostic" })
keyset("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
keyset("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev error" })
keyset("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next warning" })
keyset("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev warning" })

-- terminal keymapping
keyset("t", "<ESC><ESC>", "<C-\\><C-n>", {desc = "Enter normal mode"})
keyset("t", "<C-h>", "<Cmd>wincmd h<CR>")
keyset("t", "<C-j>", "<Cmd>wincmd j<CR>")
keyset("t", "<C-k>", "<Cmd>wincmd k<CR>")
keyset("t", "<C-l>", "<Cmd>wincmd l<CR>")
keyset("t", "<C-/>", "<Cmd>close<CR>", { desc = "Hide terminal" })
