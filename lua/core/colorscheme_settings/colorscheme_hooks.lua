-- Override your colors here
local augroup, autocmd = vim.api.nvim_create_augroup, vim.api.nvim_create_autocmd
-- These are all user autocmds
augroup("user", {})

-- They have mehh.. highlighting by default for FloatBorder and floatNormal
local weird_borders_schemes = {"everforest","gruvbox-material","edge","sonokai","monokaipro"}
local locate = function( table, value )
	for i = 1, #table do
		if table[i] == value then return true end
	end
	return false
end

local fix_borders = function ()
	if locate(weird_borders_schemes,vim.g.colors_name) then
		vim.cmd("highlight! link FloatBorder Normal")
		vim.cmd("highlight! link NormalFloat Normal")
	end
end

-- smooth cursor reload on colorscheme change
local ok_animate , animate = pcall(require,"mini.animate")
local fix_animation = function ()
	if ok_animate then
		animate.setup()
	end
end


-- local okSaga ,saga = pcall(require,"lspsaga")
-- local fix_winbar = function ()
-- 	if okSaga then
-- 		require('lspsaga').setup({
-- 			-- your configuration
-- 			symbol_in_winbar = {
-- 				enable = true
-- 			},
-- 		})
-- 	end
-- end

autocmd("ColorScheme",{
	callback = function ()
		fix_borders()
		fix_animation()
		-- fix_winbar()
	end,
	group="user",
})

