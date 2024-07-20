local M = {}

function M.set_local_indent(size)
	vim.opt_local.tabstop = size
	vim.opt_local.shiftwidth = size
	vim.opt_local.softtabstop = size
end

return M
