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
	"6.Save this session and reload on next VimEnter",
}

-- For option 6
local augroup, autocmd = vim.api.nvim_create_augroup, vim.api.nvim_create_autocmd
-- These are all user autocmds
augroup("quitter", {})

-- Clear previous search highlight on switch enter
autocmd('VimEnter', {
	callback = function()
		if file_exists("/tmp/mysession.vim") then
			vim.cmd [[source /tmp/mysession.vim]]
		local exec_run = string.format("rm /tmp/mysession.vim")
		vim.fn.jobstart(exec_run)
		vim.notify("Reopened Previous Session.Note that the saved session is now deleted.")
		end
	end,
	group = "quitter",
	pattern = '*',
})


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
		vim.cmd("qa!")
	end

	if chosen == closeOptions[6] then
		vim.cmd("mksession /tmp/mysession.vim")
		vim.notify("Saved this session on /tmp/mysession.vim.")
	end
end

function file_exists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local enter = function(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	actions.close(prompt_bufnr)
	closeCmds(selected[1])
end


local opts = {
	finder = finders.new_table(closeOptions),
	sorter = conf.generic_sorter(),
	sorting_stratergy = "ascending",
	prompt_title = "Frequent Buffer Cmds",

	attach_mappings = function(prompt_bufnr, map)
		map("i", "<CR>", enter)
		map("i", "<Esc>", actions.close)
		return true
	end
}

local closer = function()
	quitter = pickers.new(opts)
	quitter:find()
end

vim.api.nvim_create_user_command("Quitter", closer, {})
map('n', "\\q", ":Quitter<cr>", { noremap = true })
