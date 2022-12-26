local map = vim.keymap.set
local async = require("plenary.async")

-- user Commands in keymaps
-- Example how to make user commands
-- Absolutely useless :: save and quit or quit without saving

local close_options = {"1.Save and quit",
"2.Close without saving",
"3.Close all buffer without saving"}

local foo = function ()
	vim.ui.select(close_options,
		{prompt="Close Buffer(s)?"},function (selected)
			if selected == nil then -- in case the user presses <Esc>
				return
			end

			if selected == close_options[1] then
				vim.cmd("wq")
			elseif selected == close_options[2] then
				vim.cmd("q!")
			else
				vim.cmd("qa!")
			end
		end)
end
vim.api.nvim_create_user_command("Foo", foo, {})
map('n',"\\q",":Foo<cr>",{noremap=true})

-- ctrl-P for Frequent at Projects
-- Your Go Projects
local gopath = vim.api.nvim_exec("echo $GOPATH",true) .. "/src"
local proj_dirs = {"~/Documents/repos/",gopath,"~/Documents/","~/Downloads/","~"}
local change_project = function()
	vim.ui.select(proj_dirs,{
		prompt = "Choose Directory",
		telescope = require("telescope.themes").get_dropdown(),
	}, function(selected)
		require "telescope".extensions.file_browser.file_browser({cwd=selected})
	end)
end
vim.api.nvim_create_user_command("ChangeProject", change_project, {})

-- New Colourscheme Picker
local ask_background = function()
	vim.ui.select({"dark","light"},{
		prompt = "Set Background",
	}, function(selected)
		if selected == nil then
			return
		end
		vim.cmd("set background="..selected)
	end)
end
vim.api.nvim_create_user_command("Background", ask_background, {})

local installed_colourschemes = vim.fn.getcompletion('',"color")
local preinstalled = {
	"blue", "darkblue", "delek", "desert", "elflord","quiet",
	"evening", "industry", "koehler", "morning", "murphy",
	"pablo", "peachpuff", "ron", "shine", "slate",
	"torte", "zellner","habamax","lunaperche","default" }
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
local downloaded = array_sub(preinstalled,installed_colourschemes)
local colorscheme_path = "~/.config/nvim/lua/core/colorscheme_settings/set_scheme.lua"
local change_scheme = function ()
	vim.ui.select(downloaded,{
		prompt = "Change Scheme",
	},function (selected)
		if selected == nil then
			return
		end

		vim.cmd("colorscheme "..selected)
		vim.ui.select({"Yes","No","Go Back"},{
			prompt = "keep this Colourscheme on next startup",
		},function (keep)
			if keep == "Yes" then
				-- I dont know if this actually runs async or not
				async.run(function()
					local exec_run = string.format("!echo 'vim.cmd[[colorscheme %s]]' > %s",selected,colorscheme_path)
					vim.cmd(exec_run)
					vim.notify(selected, vim.log.levels.WARN, {
						title = "Changed Colorscheme Permanently",
						timeout=2000,
					})
				end)
			elseif keep == "No" then
				vim.notify({ "Changed Colorscheme", "Will Reset on next startup" }, "info", {
					title = "Changed Scheme Temporarily",
					timeout = 1000,
				})
				return
			else
				vim.cmd[[Newcolorscheme]]
			end
		end)
	end)
end
vim.api.nvim_create_user_command("Newcolorscheme", change_scheme, {})

-- Map these commands if you have to
map('n',"<leader>cs",":Newcolorscheme<cr>",{noremap=true})
map('n',"<C-p>",":ChangeProject<cr>",{noremap=true})
map('n',"<C-b>",":Background<cr>",{noremap=true})

