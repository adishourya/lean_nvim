-- Autocmds
-- Statusline autocmds are in statusline.lua file
local augroup, autocmd = vim.api.nvim_create_augroup, vim.api.nvim_create_autocmd
-- These are all user autocmds
augroup("user", {})

-- Clear previous search highlight on switch enter
autocmd('BufEnter', {
	callback = function()
		vim.cmd [[let @/ = ""]]
	end,
	group = "user",
	pattern = '*',
})

-- Highlight whats yanked
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "PmenuSel", timeout = 050 })
	end,
	group = "user",
})

-- Inform when packer done
autocmd("User", {
	pattern = "PackerCompileDone",
	callback = function() vim.notify("Compile complete!", vim.log.levels.INFO, { title = "Packer" }) end,
	group = "user",
})



-- Make and load Folds
-- .?* to make sure its not a directory
autocmd("BufWinLeave", {
	callback = function()
		vim.cmd("mkview")
	end,
	group = "user",
	pattern = "*.?*",
})


autocmd("BufWinEnter", {
	callback = function()
		vim.cmd("silent! loadview")
	end,
	group = "user",
	pattern = "*.?*",
})

-- Format before save
autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format()
	end,
	group = "user",
	pattern =  "*.?*",
})

vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})
