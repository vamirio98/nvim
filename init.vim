" append to runtime path
let s:home = expand("<sfile>:p:h")
execute 'set runtimepath+=' . s:home

lua require("config.options")
lua require("config.keymaps")
lua require("config.autocmds")
lua require("config.lazy")
