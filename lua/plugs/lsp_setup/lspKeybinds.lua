local map = vim.keymap.set
--lsp stuff
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lspconfig_keybinds = {
	outline ="<leader>o",
	finder = "gh",
	declaration = "gD",
	definition = "gd",
	preview_definition = "<leader>pd",
	hover = "K",
	implementation = "gi",
	signature_help = "gk",
	add_workspace_folder = "<leader>wa",
	remove_workspace_folder = "<leader>wr",
	list_workspace_folders = "<leader>wl",
	type_definition = "<leader>D",
	rename = "<leader>rn",
	code_action = "<leader>ca",
	references = "gr",
	float_diagnostics = "ge",
	goto_prev = "[d",
	goto_next = "]d",
	goto_err_prev = "[E",
	goto_err_next = "]E",
	set_loclist = "<leader>q",
	formatting = "<leader>fm",
}



local ok_saga, saga = pcall(require, 'lspsaga')
if ok_saga then
	-- lspsaga
	saga.init_lsp_saga()
	map("n",lspconfig_keybinds.outline, "<cmd>LSoutlineToggle<CR>", {silent=true})
	map("n", lspconfig_keybinds.finder, "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
	map("n", lspconfig_keybinds.code_action, "<cmd>Lspsaga code_action<CR>", { silent = true })
	map("v", lspconfig_keybinds.code_action, "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })
	map("n", lspconfig_keybinds.references, "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.rename, "<cmd>Lspsaga rename<CR>", { silent = true })
	map("n", lspconfig_keybinds.preview_definition, "<cmd>Lspsaga peek_definition<CR>", { silent = true })
	map("n", lspconfig_keybinds.definition, "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.float_diagnostics, "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
	map("n", lspconfig_keybinds.goto_prev, "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
	map("n", lspconfig_keybinds.goto_next, "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
	map("n", lspconfig_keybinds.goto_err_prev, function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true })
	map("n", lspconfig_keybinds.goto_err_next, function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true })
	map("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
	map("n", lspconfig_keybinds.hover, "<cmd>Lspsaga hover_doc<CR>", { silent = true })
	map("n", lspconfig_keybinds.formatting, "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true })
else
	-- normal
	map("n", lspconfig_keybinds.declaration, "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.definition, "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.hover, "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.implementation, "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.signature_help, "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.add_workspace_folder, "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.remove_workspace_folder, "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.list_workspace_folders,
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", { noremap = true })
	map("n", lspconfig_keybinds.type_definition, "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.rename, "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.code_action, "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.references, "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.float_diagnostics, "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.goto_prev, "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.goto_next, "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.set_loclist, "<cmd>lua vim.diagnostic.setloclist()<CR>", { noremap = true })
	map("n", lspconfig_keybinds.formatting, "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true })

end
