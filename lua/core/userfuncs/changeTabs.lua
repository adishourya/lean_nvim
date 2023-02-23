local changetabs = function ()
	vim.ui.select({'2', '4', '8'}, {
		prompt = "Choose tabstop for this file",
		telescope = require("telescope.themes").get_cursor(),
	}, function(selected)
		local exec_run = string.format("setlocal tabstop=%s shiftwidth=%s softtabstop=%s",selected,selected,selected)
		vim.cmd(exec_run)
		vim.cmd[[normal ggVG ==]]
	end)
end

vim.api.nvim_create_user_command("ChangeTabs", changetabs, {})
