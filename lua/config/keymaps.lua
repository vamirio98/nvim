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

keyset("t", "<ESC>", "<C-\\><C-N>")
