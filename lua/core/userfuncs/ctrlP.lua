-- Your trial and error scratchpad
local map = vim.keymap.set

local ok_telescope,telescope = pcall(require, "telescope")
if not (ok_telescope) then
	print("Telescope Not Loaded")
	return
end

-- ctrl-P for Frequent at Projects
-- Your Go Projects
-- require "telescope".extensions.file_browser.file_browser({cwd=selected})
local gopath = vim.api.nvim_exec("echo $GOPATH",true) .. "/src"
local proj_dirs = {"~/Documents/repos/",gopath,"~/Documents/","~/Downloads/","~"}


local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")

function enter(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	actions.close(prompt_bufnr)
	telescope.extensions.file_browser.file_browser({ cwd=selected[1] })
end


local opts = {
	finder = finders.new_table(proj_dirs),
	sorter = sorters.get_generic_fuzzy_sorter({}),
	sorting_stratergy = "ascending",

	attach_mappings = function(prompt_bufnr, map)
		map("i", "<CR>", enter)
		return true
	end
}

local change_projects = function()
	ctrlp = pickers.new(opts)
	ctrlp:find()
end
vim.api.nvim_create_user_command("ChangeProject", change_projects, {})
map('n',"<C-p>",":ChangeProject<cr>",{noremap=true})