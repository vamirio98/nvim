local config_dir = vim.fn.expand("~/.config/nvim")
local data_dir = vim.fn.expand("~/.config/nvim-data")
-- where all plugins will be installed
local plugin_dir = vim.fn.expand("~/.config/nvim-data/lazy")

if vim.fn.exists("g:disabled_plugins") == 0 then
	vim.g.disabled_plugins = {}
end

-- Bootstrap lazy.nvim
local lazypath = plugin_dir .. "/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	root = plugin_dir, -- directory where plugins will be installed
	lockfile = config_dir .. "/lazy-lock.json",
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "gruvbox" } },
	-- automatically check for plugin updates
	checker = { enabled = false },
	change_detection = {
		enabled = false,
	},
	pkg = {
		cache = data_dir .. "/lazy/pkg-cache.lua",
	},
	rocks = {
		root = data_dir .. "/lazy-rocks",
	},
	performance = {
		rtp = {
			reset = false,
			disabled_plugins = vim.g.disabled_plugins,
		},
	},
	readme = {
		root = data_dir .. "/lazy/readme",
	},
	state = data_dir .. "/lazy/state.json",
})
