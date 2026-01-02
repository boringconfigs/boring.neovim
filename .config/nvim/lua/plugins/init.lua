local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
		if not ev.data.active then
			vim.cmd.packadd("nvim-treesitter")
		end
		vim.cmd("TSUpdate")
	end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

vim.pack.add({
	"https://github.com/sainnhe/gruvbox-material",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/tpope/vim-surround",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/EskelinenAntti/omarchy-theme-loader.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	"https://github.com/tpope/vim-fugitive",
})

require("plugins.treesitter")
require("plugins.lsp")
require("plugins.formatter")

local fzfLua = require("fzf-lua")
fzfLua.setup({
	grep = {
		rg_opts = "--hidden --line-number --column --no-heading --smart-case --color=never --glob=!node_modules/* --glob=!.git/* --glob=!build/* --glob=!package-lock.json",
	},
})

vim.keymap.set("n", "<leader>f", fzfLua.files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader><leader>", fzfLua.files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>/", fzfLua.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>b", fzfLua.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>d", fzfLua.diagnostics_workspace, { desc = "Telescope diagnostics" })
vim.keymap.set("n", "<leader>r", fzfLua.lsp_references, { desc = "Telescope LSP references" })

vim.cmd.colorscheme("gruvbox-material")
require("omarchy-theme-loader").setup({
	themes = {
		["tokyo-night"] = { colorscheme = "slate" },
		["catppuccin"] = { colorscheme = "blue" },
		["everforest"] = { colorscheme = "desert" },
		["gruvbox"] = { colorscheme = "retrobox" },
		["osaka-jade"] = { colorscheme = "slate" },
		["kanagawa"] = { colorscheme = "slate" },
		["nord"] = { colorscheme = "blue" },
		["matte-black"] = { colorscheme = "koehler" },
		["ristretto"] = { colorscheme = "koehler" },
		["flexoki-light"] = { colorscheme = "morning" },
		["rose-pine"] = { colorscheme = "morning" },
		["catppuccin-latte"] = { colorscheme = "delek" },
	},
})

require("omarchy-theme-loader.transparency").set_transparent_background()

vim.api.nvim_create_user_command("Today", function()
	require("plugins.notes").open_daily_note()
end, {})

vim.api.nvim_create_user_command("Yesterday", function()
	require("plugins.notes").open_yesterday()
end, {})

vim.api.nvim_create_user_command("Tomorrow", function()
	require("plugins.notes").open_tomorrow()
end, {})
