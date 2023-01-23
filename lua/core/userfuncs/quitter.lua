-- Your trial and error scratchpad
local map = vim.keymap.set

local ok_telescope, telescope = pcall(require, "telescope")
if not (ok_telescope) then
	print("Telescope Not Loaded")
	return
end

-- Quitter for lua
-- * might extend to make session and close
-- * load session when you open next time

closeOptions = {
	"1.Save and Close this buffer",
	"2.Format this buffer",
	"3.Dont Save and Close this buffer",
	"4.Save and Close all buffers",
	"5.Dont Save and Close all buffers",
}

local closeCmds = function(chosen)
	if chosen == closeOptions[1] then
		vim.cmd("wq")
	end

	if chosen == closeOptions[2] then
		vim.lsp.buf.format()
	end

	if chosen == closeOptions[3] then
		vim.cmd("q!")
	end

	if chosen == closeOptions[4] then
		vim.cmd("wqa")
	end

	if chosen == closeOptions[5] then
		vim.cmd("wq")
	end
end


local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")

local enter = function(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	actions.close(prompt_bufnr)
	closeCmds(selected[1])
end

local escape = function(prompt_bufnr)
	actions.close(prompt_bufnr)
end


local opts = {
	finder = finders.new_table(closeOptions),
	sorter = sorters.get_generic_fuzzy_sorter({}),
	sorting_stratergy = "ascending",
	prompt_title = "Frequent Buffer Cmds",

	attach_mappings = function(prompt_bufnr, map)
		map("i", "<CR>", enter)
		map("i", "<Esc>", escape)
		return true
	end
}

local closer = function()
	quitter = pickers.new(opts)
	quitter:find()
end

vim.api.nvim_create_user_command("Quitter", closer, {})
map('n', "\\q", ":Quitter<cr>", { noremap = true })
