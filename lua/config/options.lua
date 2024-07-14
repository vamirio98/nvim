-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

if vim.fn.has('multi_byte') == 1 then
  -- encoding
  if vim.fn.has('win32') == 0 then
    -- terminal encoding
    vim.opt.termencoding = 'utf-8'
  end
  -- default file encoding
  vim.opt.fileencoding = 'utf-8'
  -- auto try the following encoding when opening a file
  vim.opt.fileencodings = 'utf-8,gbk,gb18030,big5,euc-jp'
  -- break at a multibyte character above 255, used for Asian text where
  -- every character is a word on its own
  vim.opt.formatoptions:append('m')
  -- don't insert a space between two multibyte characters (like Chinese)
  -- when join lines
  vim.opt.formatoptions:append('B')
end

if vim.fn.has('autocmd') == 1 then
  vim.cmd([[filetype plugin indent on]])
end
if vim.fn.has('syntax') == 1 then
  vim.cmd([[
    syntax enable
    syntax on
  ]])
end

-- round indent to multiple of 'shiftwidth' (default 8, length of a tab)
vim.opt.shiftround = true

-- show the matching brackets
vim.opt.showmatch = true
-- how long will the matching brackets shows, unit: s
vim.opt.matchtime = 2

-- set line number
vim.opt.number = true
-- cursorline
vim.opt.cursorline = true
-- show a column line in width 80
vim.opt.colorcolumn = '80'

-- when split a window vertically, display the new one on the right side
vim.opt.splitright = true

-- make the delimiter visible
vim.opt.list = true
vim.opt.listchars = {tab = '  ', trail = '.'}

-- fold
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 999
