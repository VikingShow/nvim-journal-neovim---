-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

set clipboard+=unnamedplus
vim.g.clipboard = {
	name = "wl-clipboard",
	copy = {
	    ["+"] = "wl-copy",
	    ["*"] = "wl-copy",
	},
	paste = {
	    ["+"] = "wl-paste",
	    ["*"] = "wl-paste",
	},
	cache_enabled = 1,
}
