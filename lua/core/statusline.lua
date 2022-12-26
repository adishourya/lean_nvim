-- Autocmds
local augroup, autocmd = vim.api.nvim_create_augroup, vim.api.nvim_create_autocmd
-- Charmap because
-- vim.fn.modes only returns single char
local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}
local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end


local function git_branch()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null")
	if branch ~= ""  then
		return "  " .. branch:gsub("\n", "")
	else
		return nil
	end
end


-- --- Minimal Statusline
-- function git_branch()
-- 	local branch = vim.fn.FugitiveHead(10)
-- 	if branch and #branch > 0 then
-- 		branch = '  ' .. branch
-- 	end
-- 	return branch
-- end


---@diagnostic disable-next-line: unused-local
local word_count = function()
	if vim.fn.wordcount().visual_words ~= nil then
		return vim.fn.wordcount().visual_words
	else
		return "Total Words "..vim.fn.wordcount().words
	end
end

local function get_progress()
	local p = vim.api.nvim_eval_statusline("%p", {}).str
		return ("|Scroll: %03d%s"):format(p, "%%")
end

local file_path = function()
	local buf_name = vim.api.nvim_buf_get_name(0)
	if buf_name == "" then return "[No Name]" end
	local home = vim.env.HOME
	local is_term = false
	local file_dir = ""

	if buf_name:sub(1, 5):find("term") ~= nil then
		file_dir = vim.env.PWD
		is_term = true
	else
		file_dir = vim.fn.expand("%:p:h")
	end

	if file_dir:find(home, 0, true) ~= nil then
		file_dir = file_dir:gsub(home, "~", 1)
	end

	if vim.api.nvim_win_get_width(0) <= 80 then
		file_dir = vim.fn.pathshorten(file_dir)
	end

	if is_term then
		return file_dir
	else
		return string.format(" • %s/%s", file_dir, vim.fn.expand("%:t"))
	end
end

function status_line()
	return table.concat {
		"%m%r%w", -- modified, readonly, and preview
		mode(), -- get current mode
		git_branch(), -- branch name
		" %<", -- spacing
		file_path(), -- smart full path filename
		"%=", -- right align
		"On Column:%c|", -- line number, column number
		word_count(), -- word count
		get_progress(),
		-- "[%{strlen(&ft)?&ft[0].&ft[1:]:'None'}]" -- file type
	}
end
vim.opt.statusline = "%!v:lua.status_line()"



-- cursorline only when insert mode and change highlighting of statusline
autocmd('InsertEnter',{
	callback = function()
		vim.opt.cursorline = true
		vim.cmd("highlight! link Statusline Cursorline")
	end,
	group = "user",
	pattern = '*',
})

autocmd('InsertLeave',{
	callback = function()
		vim.opt.cursorline = false
		vim.cmd("highlight! link Statusline StatusLine")
	end,
	group = "user",
	pattern = '*',
})

---Set visual highlight
autocmd('ModeChanged', {
	pattern = '*:[vV\x16]', -- going into visual
	callback = function()
		vim.cmd("highlight! link Statusline Visual")
	end,
})

---Reset visual highlight
autocmd('ModeChanged', {
	pattern = '[vV\x16]:n',
	callback = function()
		vim.cmd("highlight! link Statusline StatusLine")
	end
})

-- Highlighting statusline is intuitive for me

-- Highlight statusline on certain modes
local change_statusline_colors= function(hlgroup)
	vim.cmd("highlight! link Statusline "..hlgroup)
end

local reset_statusline = function ()
	vim.cmd("highlight! link Statusline Statusline")
end

local blink = function (duration,hlgroup)
	local i = 0
	local timer = vim.loop.new_timer()
	timer:start(0,duration,vim.schedule_wrap(function ()
		change_statusline_colors(hlgroup)
		if i > 1 then
			timer:close()
			reset_statusline()
		end
		i = i + 1
	end))
end

-- Highlight statusline when yanked or deleted
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "PmenuSel", timeout = 050 })
		blink(050,"PmenuSel")
	end,
	group = "user",
})

------------ Winbar--------------------

local function get_file_name(include_path)
	local file_name = require('lspsaga.symbolwinbar').get_file_name()
	if vim.fn.bufname '%' == '' then return '' end
	if include_path == false then return file_name end
	-- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
	local sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'
	local path_list = vim.split(string.gsub(vim.fn.expand '%:~:.:h', '%%', ''), sep)
	local file_path = ''
	for _, cur in ipairs(path_list) do
		file_path = (cur == '.' or cur == '~') and '' or
		file_path .. cur .. ' ' .. '%#LspSagaWinbarSep#>%*' .. ' %*'
	end
	return file_path .. file_name
end

local function setWinbar()
	local exclude = {
		['terminal'] = true,
		['toggleterm'] = true,
		['prompt'] = true,
		['NvimTree'] = true,
		['help'] = true,
	} -- Ignore float windows and exclude filetype
	if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
		vim.wo.winbar = ''
	else
		local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
		local sym
		if ok then sym = lspsaga.get_symbol_node() end
		local win_val = ''
		win_val = get_file_name(false) -- set to true to include path
		if sym ~= nil then win_val = win_val .. sym end
		vim.wo.winbar = win_val
	end
end

local enter_events = {'ColorScheme', 'BufEnter', 'BufWinEnter', 'CursorMoved',"DirChanged"}

vim.api.nvim_create_autocmd(enter_events, {
	pattern = '*',
	callback = function() setWinbar() end,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'LspsagaUpdateSymbol',
	callback = function() setWinbar() end,
})
