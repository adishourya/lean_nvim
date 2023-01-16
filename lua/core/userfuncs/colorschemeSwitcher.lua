-- Your trial and error scratchpad
local map = vim.keymap.set

local ok_telescope, _ = pcall(require, "telescope")
if not (ok_telescope) then
	print("Telescope Not Loaded")
	return
end

-- Making a new telescope colorscheme picker with live preview hopefully
local current_scheme = vim.g.colors_name
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")


local installed_colourschemes = vim.fn.getcompletion('', "color")
local preinstalled = {
	"blue", "darkblue", "delek", "desert", "elflord", "quiet",
	"evening", "industry", "koehler", "morning", "murphy",
	"pablo", "peachpuff", "ron", "shine", "slate",
	"torte", "zellner", "habamax", "lunaperche", "default"
}
-- remove preinstalled colorschemes from the installed list
local array_sub = function(t1, t2)
	local t = {}
	for i = 1, #t1 do
		t[t1[i]] = true;
	end
	for i = #t2, 1, -1 do
		if t[t2[i]] then
			table.remove(t2, i);
		end
	end
	return t2
end
local downloaded = array_sub(preinstalled, installed_colourschemes)

function escape(prompt_bufnr)
	local cmd = "colorscheme " .. current_scheme
	vim.cmd(cmd)
	actions.close(prompt_bufnr)
end

function enter(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
	actions.close(prompt_bufnr)
	local csPath = vim.fn.expand("~/.config/nvim/lua/core/colorscheme_settings/set_scheme.lua")
	local exec_run = string.format("echo 'vim.cmd[[colorscheme %s]]' > %s",selected[1],csPath)
	vim.fn.jobstart(exec_run)
	vim.notify("Colorscheme Change From "..current_scheme.." to "..selected[1])
end

function preview_next(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)

end

function preview_prev(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
end

local opts = {
	finder = finders.new_table(downloaded),
	sorter = sorters.get_generic_fuzzy_sorter({}),
	sorting_stratergy = "ascending",

	attach_mappings = function(prompt_bufnr, map)
		map("i", "<CR>", enter)
		map("i", "<ESC>", escape)
		map("i", "<C-n>", preview_next)
		map("i", "<C-p>", preview_prev)
		return true
	end
}

local change_scheme = function()
	colors = pickers.new(opts)
	colors:find()
end
vim.api.nvim_create_user_command("Newcolorscheme", change_scheme, {})
map('n',"<leader>cs",":Newcolorscheme<cr>",{noremap=true})
